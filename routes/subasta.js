const { Router } = require("express");
const router = Router();
const controller = require("../controller/subasta");

router.get("/api/subasta/get-deps", controller.get_deps);
module.exports = router;
