const pool = require("../db/db");

const getPersona = async (request, response) => {
  await pool.query("SELECT * FROM Persona", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getAgente = async (request, response) => {
  await pool.query("SELECT * FROM Agente", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getCliente = async (request, response) => {
  await pool.query("SELECT * FROM Cliente", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getSucursal = async (request, response) => {
  await pool.query("SELECT * FROM Sucursal", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getContVehiculo = async (request, response) => {
  var resp = {};
  await pool.query(
    "SELECT * FROM Contrata_Vehiculo",
    async (error, results) => {
      if (error) {
        throw error;
      }
      resp.Contratos = results.rows;
      await pool.query("SELECT * FROM Vehiculo", async (error, results) => {
        if (error) {
          throw error;
        }
        resp.Vehiculos = results.rows;
        await pool.query(
          "SELECT c.*,p.* FROM Cliente c INNER JOIN Persona p on p.id_persona = c.id_cliente",
          async (error, results) => {
            if (error) {
              throw error;
            }
            resp.Clientes = results.rows;
            await pool.query(
              "SELECT a.*,p.* FROM Agente a INNER JOIN Persona p on p.id_persona = a.id_agente",
              async (error, results) => {
                if (error) {
                  throw error;
                }
                resp.Agentes = results.rows;
                response.status(200).json(resp);
              }
            );
          }
        );
      });
    }
  );
};

const getVehiculo = async (request, response) => {
  await pool.query("SELECT * FROM Vehiculo", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getContVida = async (request, response) => {
  var resp = {};
  await pool.query("SELECT * FROM Contrata_Vida", async (error, results) => {
    if (error) {
      throw error;
    }
    resp.Contratos = results.rows;
    await pool.query("SELECT * FROM Persona", async (error, results) => {
      if (error) {
        throw error;
      }
      resp.Personas = results.rows;
      await pool.query(
        "SELECT c.*,p.* FROM Cliente c INNER JOIN Persona p on p.id_persona = c.id_cliente",
        async (error, results) => {
          if (error) {
            throw error;
          }
          resp.Clientes = results.rows;
          await pool.query(
            "SELECT a.*,p.* FROM Agente a INNER JOIN Persona p on p.id_persona = a.id_agente",
            async (error, results) => {
              if (error) {
                throw error;
              }
              resp.Agentes = results.rows;
              await pool.query("SELECT * FROM Vida", async (error, results) => {
                if (error) {
                  throw error;
                }
                resp.Vida = results.rows;
                response.status(200).json(resp);
              });
            }
          );
        }
      );
    });
  });
};

const getVida = async (request, response) => {
  await pool.query("SELECT * FROM Vida", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getContInmueble = async (request, response) => {
  var resp = {};
  await pool.query(
    "SELECT * FROM Contrata_Inmueble",
    async (error, results) => {
      if (error) {
        throw error;
      }
      resp.Contratos = results.rows;
      await pool.query("SELECT * FROM Inmueble", async (error, results) => {
        if (error) {
          throw error;
        }
        resp.Inmuebles = results.rows;
        await pool.query(
          "SELECT c.*,p.* FROM Cliente c INNER JOIN Persona p on p.id_persona = c.id_cliente",
          async (error, results) => {
            if (error) {
              throw error;
            }
            resp.Clientes = results.rows;
            await pool.query(
              "SELECT a.*,p.* FROM Agente a INNER JOIN Persona p on p.id_persona = a.id_agente",
              async (error, results) => {
                if (error) {
                  throw error;
                }
                resp.Agentes = results.rows;
                response.status(200).json(resp);
              }
            );
          }
        );
      });
    }
  );
};

const getEmpleado = async (request, response) => {
  await pool.query("SELECT * FROM Empleado", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getUsuario = async (request, response) => {
  await pool.query("SELECT * FROM Usuario", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getPoliza = async (request, response) => {
  await pool.query("SELECT * FROM Poliza", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getCategoria = async (request, response) => {
  await pool.query("SELECT * FROM Categoria", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getTipo = async (request, response) => {
  await pool.query("SELECT * FROM Tipo_Cobertura", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getInmueble = async (request, response) => {
  await pool.query("SELECT * FROM Inmueble", (error, results) => {
    if (error) {
      throw error;
    }
    response.status(200).json(results.rows);
  });
};

const getSubastasTiendas = async (request, response) => {
  const tienda_id = request.params.tienda_id;
  await pool.query(
    'SELECT * From "AA_Subasta_Evento" inner join "AA_Tienda_Subasta" on "AA_Tienda_Subasta".subasta="AA_Subasta_Evento".id inner join "AA_Tienda" on "AA_Tienda".id= "AA_Tienda_Subasta".tienda',
    (error, results) => {
      if (error) {
        throw error;
      }
      response.status(200).json(results.rows);
    }
  );
};

const createPersona = async (request, response) => {
  const { nombre_persona, num_telpersona, tipo_persona } = request.body;
  await pool.query(
    "INSERT INTO Persona (nombre_persona, num_telpersona, tipo_persona) VALUES ($1, $2, $3)",
    [nombre_persona, num_telpersona, tipo_persona],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createAgente = async (request, response) => {
  const { id_agente, tipo_agente, direc_agente } = request.body;
  console.log(request.body);
  await pool.query(
    "INSERT INTO Agente VALUES ($1, $2, $3)",
    [id_agente, tipo_agente, direc_agente],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createContVehiculo = async (request, response) => {
  const {
    matricula,
    id_cliente,
    id_agente,
    monto_com_ag,
    recargo,
    descuento,
    tipo
  } = request.body;
  await pool.query(
    "INSERT INTO Contrata_Vehiculo (matricula, id_cliente, id_agente, monto_com_ag, recargo, descuento, tipo, fecha_contrato, estado_contrato) VALUES ($1, $2, $3, $4, $5, $6, $7, CURRENT_DATE, 'Activo')",
    [matricula, id_cliente, id_agente, monto_com_ag, recargo, descuento, tipo],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createContVida = async (request, response) => {
  const {
    id_vida,
    id_persona_vida,
    id_cliente,
    id_agente,
    monto_com_ag,
    tipo
  } = request.body;
  await pool.query(
    "INSERT INTO Contrata_Vida (id_vida, id_persona_vida, id_cliente, id_agente, monto_com_ag, tipo, fecha_contrato, estado_contrato) VALUES ($1, $2, $3, $4, $5, $6, CURRENT_DATE, 'Activo')",
    [id_vida, id_persona_vida, id_cliente, id_agente, monto_com_ag, tipo],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
        console.log(e);
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createContInmueble = async (request, response) => {
  const {
    id_inmueble,
    id_cliente,
    id_agente,
    monto_com_ag,
    tipo
  } = request.body;
  await pool.query(
    "INSERT INTO Contrata_Inmueble (id_inmueble, id_cliente, id_agente, monto_com_ag, tipo, fecha_contrato, estado_contrato) VALUES ($1, $2, $3, $4, $5, CURRENT_DATE, 'Activo')",
    [id_inmueble, id_cliente, id_agente, monto_com_ag, tipo],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createEmpleado = async (request, response) => {
  const { id_empleado, fecha_inicio_empresa } = request.body;
  await pool.query(
    "INSERT INTO Empleado VALUES ($1, $2)",
    [id_empleado, fecha_inicio_empresa],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
        console.log(e);
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createCliente = async (request, response) => {
  const {
    apellido_cliente,
    direc_cliente,
    calle,
    ciudad,
    genero,
    fecha_nac,
    profesion,
    id_sucursal
  } = request.body;
  await pool.query(
    "INSERT INTO Cliente VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
    [
      apellido_cliente,
      direc_cliente,
      calle,
      ciudad,
      genero,
      fecha_nac,
      profesion,
      id_sucursal
    ],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createPoliza = async (request, response) => {
  const { descripcion_poliza, tipo, prima } = request.body;
  await pool.query(
    "INSERT INTO Poliza VALUES ($1, $2, $3)",
    [descripcion_poliza, tipo, prima],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createVehiculo = async (request, response) => {
  const {
    matricula,
    marca,
    modelo,
    annio,
    id_categoria,
    id_tipo_cobertura
  } = request.body;
  console.log(request.body);
  await pool.query(
    "INSERT INTO Vehiculo VALUES ($1, $2, $3, $4, $5, $6)",
    [matricula, marca, modelo, annio, id_categoria, id_tipo_cobertura],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
        console.log(e);
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createUsuario = async (request, response) => {
  const {
    nombre_usuario,
    email,
    pass,
    nombre,
    apellido,
    sexo,
    id_ciudad
  } = request.body;
  await pool.query(
    "INSERT INTO Usuario VALUES ($1, $2, $3, $4, $5, $6, $7)",
    [nombre_usuario, email, pass, nombre, apellido, sexo, id_ciudad],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createVida = async (request, response) => {
  const { ip_vida, prima, cobertura } = request.body;
  await pool.query(
    "INSERT INTO Vida VALUES ($1, $2, $3)",
    [ip_vida, prima, cobertura],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

const createInmueble = async (request, response) => {
  const { direc_inmueble, valor, contenido, riesgos_auxiliares } = request.body;
  await pool.query(
    "INSERT INTO Inmueble (direc_inmueble, valor, contenido, riesgos_auxiliares) VALUES ($1, $2, $3, $4)",
    [direc_inmueble, valor, contenido, riesgos_auxiliares],
    (e, results) => {
      if (e) {
        response.status(500).json({ error: e });
      } else {
        response.status(200).json(results.rows);
      }
    }
  );
};

module.exports = {
  getUsuario,
  getPersona,
  getEmpleado,
  getAgente,
  getCliente,
  getPoliza,
  getVehiculo,
  getVida,
  getCategoria,
  getTipo,
  getSucursal,
  getContVida,
  getContVehiculo,
  getContInmueble,
  getInmueble,
  createUsuario,
  createPersona,
  createEmpleado,
  createAgente,
  createCliente,
  createPoliza,
  createInmueble,
  createVehiculo,
  createVida,
  // createCategoria,
  // createTipo,
  // createSucursal,
  createContVida,
  createContInmueble,
  createContVehiculo
};
