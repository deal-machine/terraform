
// block provider_tipodoprovider name
resource "local_file" "example" {
    filename = "exemple.txt"
    content = var.content
}

variable "content" {}