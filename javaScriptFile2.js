// for the API Security finding
const express = require('express');
const app = express();
// Undocumented endpoint not declared in openapi.yaml
app.delete('/api/v1/internal/cleanup', (req, res) => {
    // Unsecured internal route
    res.status(200).send({ status: "cleaned" });
});
app.listen(3000);