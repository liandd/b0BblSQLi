<?php
#-- Datos para conectarse a la base de Datos
$server = 'localhost';
$username = '<user>';
$password = '<user_password>';
$database = '<database_name>';
error_reporting(0);

mysqli_report(MYSQLI_REPORT_OFF);

$conn = new mysqli($server, $username, $password, $database);

#-- Buena práctica
$id = mysqli_real_escape_string($conn, $_GET['id']);

if ($conn->connect_error) {
  http_response_code(404);
  exit();
}

$id = $_GET['id'] ?? '';

#-- Hasta aquí llega la buena práctica, ya que eliminar los caracteres especiales como las comillas simples no hace nada si en el PHP la variable no está dentro de comillas..
$data = mysqli_query($conn, "select username from users where id = $id");
$response = mysqli_fetch_array($data);

if (! isset($response['username'])) {
  http_response_code(404);
}
