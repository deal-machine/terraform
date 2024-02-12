
// block provider_tipodoprovider name
resource "local_file" "example" {
    filename = "exemple.txt"
    content = var.content
}


variable "content" {}

data "local_file" "content-example" {
    filename = "exemple.txt"
}

output "content-name" {
  value = data.local_file.content-example.content
}

output "id-file" {
  value = resource.local_file.example.id
}