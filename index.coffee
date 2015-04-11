app = (require "express")()

console.log process.env.PORT or 8000
app.listen process.env.PORT or 8000