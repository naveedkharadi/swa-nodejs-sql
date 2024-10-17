// src/components/EmployeeList.js  
import React, { useState, useEffect } from 'react';  
import { PublicClientApplication } from '@azure/msal-browser';  
import { msalConfig, appConfig } from '../config';  
  
const msalInstance = new PublicClientApplication(msalConfig);  
  
const EmployeeList = () => {  
    const [employees, setEmployees] = useState([]);  
    const [employeeId, setEmployeeId] = useState('');  
    const [accessToken, setAccessToken] = useState('');  
  
    const initializeMsal = async () => {  
        try {  
            await msalInstance.initialize();  
            login();  
        } catch (error) {  
            console.error('Failed to initialize MSAL:', error);  
        }  
    };  
  
    const login = async () => {  
        try {  
            const response = await msalInstance.loginPopup(appConfig.loginRequest);  
            console.log(response);  
            setAccessToken(response.accessToken);  
        } catch (error) {  
            console.error(error);  
        }  
    };  
  
    const callApi = async (endpoint) => {  
        const response = await fetch(endpoint, {  
            method: "GET",  
            headers: {  
                "Authorization": `Bearer ${accessToken}`  
            }  
        });  
        return response.json();  
    };  
  
    const listEmployees = async () => {  
        const data = await callApi(`${appConfig.apiRootUrl}/employees`);  
        console.log(data);  
        setEmployees(data);  
    };  
  
    const searchEmployee = async () => {  
        const data = await callApi(`${appConfig.apiRootUrl}/employees/${employeeId}`);  
        console.log(data);  
        setEmployees(data);  
    };  
  
    const displayEmployees = (employees) => {  
        if (employees.length === 0) {  
            return <p>No data found</p>;  
        }  
        return (  
            <table>  
                <thead>  
                    <tr>  
                        <th>EmployeeId</th>  
                        <th>FirstName</th>  
                        <th>LastName</th>  
                        <th>DateOfBirth</th>  
                        <th>DateOfJoining</th>  
                        <th>DepartmentName</th>  
                    </tr>  
                </thead>  
                <tbody>  
                    {employees.map(employee => (  
                        <tr key={employee.EmployeeId}>  
                            <td>{employee.EmployeeId}</td>  
                            <td>{employee.FirstName}</td>  
                            <td>{employee.LastName}</td>  
                            <td>{employee.DateOfBirth}</td>  
                            <td>{employee.DateOfJoining}</td>  
                            <td>{employee.DepartmentName}</td>  
                        </tr>  
                    ))}  
                </tbody>  
            </table>  
        );  
    };  
  
    useEffect(() => {  
        initializeMsal();  
    }, []);  
  
    return (  
        <div>  
            <button id="listEmployeesBtn" onClick={listEmployees}>List All Employees</button>  
            <input  
                type="text"  
                id="employeeIdInput"  
                value={employeeId}  
                onChange={(e) => setEmployeeId(e.target.value)}  
                placeholder="Employee ID"  
            />  
            <button id="searchEmployeeBtn" onClick={searchEmployee}>Search Employee</button>  
            <div id="employeeTableContainer">  
                {displayEmployees(employees)}  
            </div>  
        </div>  
    );  
};  
  
export default EmployeeList;  
