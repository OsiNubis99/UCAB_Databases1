const { Router } = require("express");
const router = Router();
const subastaController = require("../controller/subasta");

router.get("/api/subasta/get-deps", subastaController.get_deps);
router.post("/api/subasta/put", subastaController.put);
router.get("/api/subasta/get/:subastaId", subastaController.get);
router.get("/api/subasta/getAll", subastaController.getAll);

module.exports = router;
