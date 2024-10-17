require('dotenv').config(); 
const express = require('express');
const sql = require('mssql');
const jwt1 = require('jsonwebtoken');
const jwksRsa = require('jwks-rsa');
const { expressjwt: jwt } = require('express-jwt');

const app = express();
app.use(express.json());

app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Authorization, Origin, X-Requested-With, Content-Type, Accept");
    next();
});

const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_DATABASE,
    tenantId: process.env.TENANT_ID,
    audience: process.env.AUDIENCE,
    b2cPolicy: process.env.B2C_POLICY,
    b2cTenant: process.env.B2C_TENANT_NAME,
    options: {
        encrypt: true,
        enableArithAbort: true
    }
};

const authenticateToken = jwt({
    secret: jwksRsa.expressJwtSecret({
        cache: true,
        rateLimit: true,
        jwksUri: `https://${config.b2cTenant}.b2clogin.com/${config.b2cTenant}.onmicrosoft.com/${config.b2cPolicy}/discovery/v2.0/keys`
    }),
    audience: `${config.audience}`,
    issuer: `https://${config.b2cTenant}.b2clogin.com/${config.tenantId}/v2.0/`,
    algorithms: ['RS256']
});


const authenticateToken1 = jwt({
    secret: jwksRsa.expressJwtSecret({
        cache: true,
        rateLimit: true,
        jwksUri: `https://techaradiorgb2c.b2clogin.com/techaradiorgb2c.onmicrosoft.com/b2c_1_sign_up_sign_in/discovery/v2.0/keys`
    }),
    audience: '5f15854f-ace0-4fb7-a3e3-7e02dd4eb6b8',
    issuer: `https://techaradiorgb2c.b2clogin.com/4d4f385e-a8a2-4c29-a2a1-9995a7a7a323/v2.0/`,
    algorithms: ['RS256']
});

app.get('/employees', authenticateToken, async (req, res) => {
    try {
        let pool = await sql.connect(config);
        let result = await pool.request().query('SELECT * FROM Employees');
        res.json(result.recordset);
    } catch (err) {
        console.log(err);
        res.status(500).send(err.message);
    }
});

app.post('/employees', authenticateToken, async (req, res) => {
    const { EmployeeId, FirstName, LastName, DateOfBirth, DateOfJoining, DepartmentName } = req.body;
    try {
        let pool = await sql.connect(config);
        await pool.request()
            .input('EmployeeId', sql.NVarChar, EmployeeId)
            .input('FirstName', sql.NVarChar, FirstName)
            .input('LastName', sql.NVarChar, LastName)
            .input('DateOfBirth', sql.Date, DateOfBirth)
            .input('DateOfJoining', sql.Date, DateOfJoining)
            .input('DepartmentName', sql.NVarChar, DepartmentName)
            .query('INSERT INTO Employees (EmployeeId, FirstName, LastName, DateOfBirth, DateOfJoining, DepartmentName) VALUES (@EmployeeId, @FirstName, @LastName, @DateOfBirth, @DateOfJoining, @DepartmentName)');
        res.status(201).send('Employee added successfully');
    } catch (err) {
        res.status(500).send(err.message);
    }
});

app.put('/employees/:id', authenticateToken, async (req, res) => {
    const { id } = req.params;
    const { EmployeeId, FirstName, LastName, DateOfBirth, DateOfJoining, DepartmentName } = req.body;
    try {
        let pool = await sql.connect(config);
        await pool.request()
            .input('Id', sql.Int, id)
            .input('EmployeeId', sql.NVarChar, EmployeeId)
            .input('FirstName', sql.NVarChar, FirstName)
            .input('LastName', sql.NVarChar, LastName)
            .input('DateOfBirth', sql.Date, DateOfBirth)
            .input('DateOfJoining', sql.Date, DateOfJoining)
            .input('DepartmentName', sql.NVarChar, DepartmentName)
            .query('UPDATE Employees SET EmployeeId = @EmployeeId, FirstName = @FirstName, LastName = @LastName, DateOfBirth = @DateOfBirth, DateOfJoining = @DateOfJoining, DepartmentName = @DepartmentName WHERE Id = @Id');
        res.send('Employee updated successfully');
    } catch (err) {
        res.status(500).send(err.message);
    }
});

app.delete('/employees/:id', authenticateToken, async (req, res) => {
    const { id } = req.params;
    try {
        let pool = await sql.connect(config);
        await pool.request()
            .input('Id', sql.Int, id)
            .query('DELETE FROM Employees WHERE Id = @Id');
        res.send('Employee deleted successfully');
    } catch (err) {
        res.status(500).send(err.message);
    }
});

app.get('/employees/:employeeId', authenticateToken, async (req, res) => {
    const { employeeId } = req.params;
    try {
        let pool = await sql.connect(config);
        let result = await pool.request()
            .input('EmployeeId', sql.NVarChar, employeeId)
            .query('SELECT * FROM Employees WHERE EmployeeId = @EmployeeId');
        res.json(result.recordset);
    } catch (err) {
        res.status(500).send(err.message);
    }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});