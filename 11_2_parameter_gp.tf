resource "aws_db_parameter_group" "pro_pg" {

    name = "pro-para-group"
    family = "mysql8.0"
  
  parameter {
    name="auto_increment_increment"
    value="2"
  }
  parameter {
    name="auto_increment_offset"
    value="1"
  }
  parameter {
    name="collation_connection"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name="collation_server"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name="character_set_client"
    value ="utf8mb4"
  }

  parameter {
    name="character_set_connection"
    value ="utf8mb4"
  }
    parameter {
    name="character_set_database"
    value ="utf8mb4"
  }
    parameter {
    name="character_set_filesystem"
    value ="utf8mb4"
  }
    parameter {
    name="character_set_server"
    value ="utf8mb4"
  }


}