resource "local_file" "my_file" {
  filename        = "automate.txt"
  content         = "learning terraform"
  file_permission = "0644"
}