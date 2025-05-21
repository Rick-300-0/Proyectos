const pool = require("../db.js");

const getAllTask = async (req, res) => {
    try {
        const results = await pool.query("SELECT * FROM tarea");
        res.json(results.rows)   
    } catch (error) {
       res.json({error: error.message}) 
    }
};

const getTask = async (req, res) => {

    try {
        const {id} = req.params;
        const results = await pool.query("SELECT * FROM tarea where id = $1", [id]);

        if(results.rows.length === 0)
            return res.status(404).json({
                message: "No encontrado",
            })
        res.json(results.rows[0]); 
    } catch (error) {
        res.json({error: error.message}) 
    }

}

const createTask = async (req, res) => {

    const { titulo, descripcion} = req.body;

    try {
        const results = await pool.query("INSERT INTO tarea (titulo, descripcion) VALUES ($1, $2) RETURNING *",
        [titulo, descripcion]);
        res.json(results.rows[0])
    } 
    catch (error) {
        res.json({error: error.message})     
        }   
};

 
const updateTask = async (req, res) => {
    const {id} = req.params;
    const {titulo, descripcion} = req.body;

    console.log(id, titulo, descripcion)

    const results = await pool.query("UPDATE tarea SET titulo = $1, descripcion = $2 WHERE id = $3",
    [titulo, descripcion, id])
  
    if(results.rows.length === 0)
    return res.status(404).json({
        message: "No encontrado",
    })

    res.json(results.rows[0]);

};

const deleteTask = async (req, res) => {
    const {id} = req.params;

<<<<<<< HEAD
    const resultado = await pool.query("DELETE * FROM task where id = $1", [id]);
    res.send("obtener todas la tarea");
=======
    const results = await pool.query("DELETE * FROM tarea where id = $1", [id]);
    res.json(results.rows[0]);
>>>>>>> 2b8860d8381f40de65cea36cc6a192a3b894ac9a
}

module.exports = {
    getAllTask,
    getTask,
    createTask,
    updateTask,
    deleteTask
}