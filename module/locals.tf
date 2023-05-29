locals {
  name = var.env != "" ? "${var.component_name}-${var.env}" : var.component_name
  db_commands = [
    "rm -rf roboshop-shell",
    "git clone https://github.com/balatuluva/roboshop-shell.git",
    "cd roboshop-shell",
    "sudo bash ${var.component_name}.sh ${var.password}"
  ]
  app_commands = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -u https://github.com/balatuluva/roboshop-ansible roboshop.yml -e env=${var.env} -e role_name=${var.component_name}"
  ]
}