import mysql from 'mysql2'

import dotenv from 'dotenv'
dotenv.config()

const pool = mysql.createPool({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
}).promise()


//Customer CRUD
export async function getCustomers(){
    const [customers] = await pool.query('SELECT * FROM customers;')
    return customers
}

export async function getCustomer(id){
    const [customer] = await pool.query(`
    SELECT * 
    FROM customers 
    WHERE id = ?
    `, [id])
    return customer[0]
}

export async function createCustomer(
    email,
    first_name = null,
    last_name= null,
    img_url=null,
    customer_type_id=1
    ){
        const [result] = await pool.query(`
            INSERT INTO customers (first_name, last_name, email, img_url, customer_type_id)
            VALUES (?, ?, ?, ?, ?)
            ;`, [first_name, last_name, email, img_url, customer_type_id])
        const id = result.insertId
        console.log(id)
        const added = await getCustomer(id)
        return added
    }

export async function updateCustomer(
    id,
    email,
    first_name,
    last_name,
    img_url=null,
    customer_type_id=1
    ){
        const [result] = await pool.query(`
            UPDATE customers
            SET first_name = ?, last_name = ?, email = ?, img_url = ?, customer_type_id =?
            WHERE id = ?
            ;`,  [first_name, last_name, email, img_url, customer_type_id, id])
        console.log(result)
        const updated = await getCustomer(id)
        return updated
    }

export async function deleteCustomer(id){
    const [result] = await pool.query(`
        DELETE FROM customers WHERE id = ?
    ;`, [id])
    console.log(result)
    return result.affectedRows
}

const deleted = await deleteCustomer(11)
console.log(deleted)
