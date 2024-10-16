const express = require('express');
const sql = require('mssql');
const jwt = require('jsonwebtoken');

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
    options: {
        encrypt: true,
        enableArithAbort: true
    }
};

const authenticateToken = (req, res, next) => {
    const token = req.headers['authorization'];
    if (!token) return res.sendStatus(401);

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) return res.sendStatus(403);
        req.user = user;
        next();
    });
};

app.get('/employees', authenticateToken, async (req, res) => {
    try {
        let pool = await sql.connect(config);
        let result = await pool.request().query('SELECT * FROM Employee');
        res.json(result.recordset);
    } catch (err) {
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
            .query('INSERT INTO Employee (EmployeeId, FirstName, LastName, DateOfBirth, DateOfJoining, DepartmentName) VALUES (@EmployeeId, @FirstName, @LastName, @DateOfBirth, @DateOfJoining, @DepartmentName)');
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
            .query('UPDATE Employee SET EmployeeId = @EmployeeId, FirstName = @FirstName, LastName = @LastName, DateOfBirth = @DateOfBirth, DateOfJoining = @DateOfJoining, DepartmentName = @DepartmentName WHERE Id = @Id');
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
            .query('DELETE FROM Employee WHERE Id = @Id');
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
            .query('SELECT * FROM Employee WHERE EmployeeId = @EmployeeId');
        res.json(result.recordset);
    } catch (err) {
        res.status(500).send(err.message);
    }
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});