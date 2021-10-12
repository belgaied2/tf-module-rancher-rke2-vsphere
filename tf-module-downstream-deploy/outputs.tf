output "import_manifest" {
value = data.http.get_import_manifest.body
}