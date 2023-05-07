components = {
  frontend = {
    name = "frontend"
    instance_type = "t3.small"
  }
  mongodb = {
    name = "mongodb"
    instance_type = "t3.small"
  }
  redis = {
    name = "redis"
    instance_type = "t3.small"
  }
  mysql = {
    name = "mysql"
    instance_type = "t3.small"
    password = "RoboShop@1"
  }
}

env = "dev"