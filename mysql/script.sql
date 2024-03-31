SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Planejamente
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Planejamente
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Planejamente` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Planejamente` ;

-- -----------------------------------------------------
-- Table `Planejamente`.`Endereço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Endereço` (
  `id` CHAR(36) NOT NULL,
  `Número` INT NOT NULL,
  `CEP` CHAR(8) NOT NULL,
  `Rua` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`Usuário`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Usuário` (
  `id` CHAR(36) NOT NULL,
  `Nome` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Sal` VARCHAR(255) NOT NULL,
  `Senha` VARCHAR(255) NOT NULL,
  `DataDeNascimento` DATE NOT NULL,
  `Telefone` VARCHAR(255) NOT NULL,
  `Endereço` CHAR(36) NOT NULL,
  `CPF` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `Endereço` (`Endereço` ASC) VISIBLE,
  CONSTRAINT `Paciente_ibfk_10`
    FOREIGN KEY (`Endereço`)
    REFERENCES `Planejamente`.`Endereço` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`Psicólogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Psicólogo` (
  `id` CHAR(36) NOT NULL,
  `Usuário_id` CHAR(36) NOT NULL,
  `CRP` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `Usuário_id`),
  INDEX `fk_Psicólogo_Usuário1_idx` (`Usuário_id` ASC) VISIBLE,
  CONSTRAINT `fk_Psicólogo_Usuário1`
    FOREIGN KEY (`Usuário_id`)
    REFERENCES `Planejamente`.`Usuário` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Consulta` (
  `id` CHAR(36) NOT NULL,
  `DataHoraInicio` DATETIME NOT NULL,
  `DataHoraFim` DATETIME NOT NULL,
  `Status` VARCHAR(255) NOT NULL,
  `Observações` VARCHAR(255) NOT NULL,
  `Psicólogo` CHAR(36) NOT NULL,
  `Link` VARCHAR(255) NOT NULL,
  `Usuário_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `Psicólogo` (`Psicólogo` ASC) VISIBLE,
  INDEX `fk_Consulta_Usuário1_idx` (`Usuário_id` ASC) VISIBLE,
  CONSTRAINT `Consulta_ibfk_2`
    FOREIGN KEY (`Psicólogo`)
    REFERENCES `Planejamente`.`Psicólogo` (`id`),
  CONSTRAINT `fk_Consulta_Usuário1`
    FOREIGN KEY (`Usuário_id`)
    REFERENCES `Planejamente`.`Usuário` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`Arquivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Arquivos` (
  `id` CHAR(36) NOT NULL,
  `Url` VARCHAR(255) NOT NULL,
  `Nome` VARCHAR(255) NOT NULL,
  `Tamanho` INT NOT NULL,
  `Extensão` VARCHAR(255) NOT NULL,
  `Consulta` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `Consulta` (`Consulta` ASC) VISIBLE,
  CONSTRAINT `Arquivos_ibfk_1`
    FOREIGN KEY (`Consulta`)
    REFERENCES `Planejamente`.`Consulta` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`Avaliação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Avaliação` (
  `id` CHAR(36) NOT NULL,
  `Consulta` CHAR(36) NOT NULL,
  `Paciente` CHAR(36) NOT NULL,
  `Descrição` VARCHAR(255) NOT NULL,
  `Usuário_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`, `Usuário_id`),
  INDEX `Consulta` (`Consulta` ASC) VISIBLE,
  INDEX `fk_Avaliação_Usuário1_idx` (`Usuário_id` ASC) VISIBLE,
  CONSTRAINT `Avaliação_ibfk_1`
    FOREIGN KEY (`Consulta`)
    REFERENCES `Planejamente`.`Consulta` (`id`),
  CONSTRAINT `fk_Avaliação_Usuário1`
    FOREIGN KEY (`Usuário_id`)
    REFERENCES `Planejamente`.`Usuário` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Especialidade` (
  `id` CHAR(36) NOT NULL,
  `Descrição` VARCHAR(255) NOT NULL,
  `Título` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`EspecialidadePsicólogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`EspecialidadePsicólogo` (
  `id` CHAR(36) NOT NULL,
  `Especialidade` CHAR(36) NOT NULL,
  `Psicólogo` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `Especialidade` (`Especialidade` ASC) VISIBLE,
  INDEX `Psicólogo` (`Psicólogo` ASC) VISIBLE,
  CONSTRAINT `EspecialidadePsicólogo_ibfk_1`
    FOREIGN KEY (`Especialidade`)
    REFERENCES `Planejamente`.`Especialidade` (`id`),
  CONSTRAINT `EspecialidadePsicólogo_ibfk_2`
    FOREIGN KEY (`Psicólogo`)
    REFERENCES `Planejamente`.`Psicólogo` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`Experiência`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Experiência` (
  `id` CHAR(36) NOT NULL,
  `DataInicio` DATE NOT NULL,
  `DataFim` DATE NULL DEFAULT NULL,
  `Instituição` VARCHAR(255) NOT NULL,
  `Cargo` VARCHAR(255) NOT NULL,
  `Descrição` VARCHAR(255) NOT NULL,
  `Psicólogo` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `Psicólogo` (`Psicólogo` ASC) VISIBLE,
  CONSTRAINT `Experiência_ibfk_1`
    FOREIGN KEY (`Psicólogo`)
    REFERENCES `Planejamente`.`Psicólogo` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Planejamente`.`Formação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Planejamente`.`Formação` (
  `id` CHAR(36) NOT NULL,
  `Instituição` VARCHAR(255) NOT NULL,
  `AnoConclusão` VARCHAR(255) NOT NULL,
  `Tipo` VARCHAR(255) NOT NULL,
  `Título` VARCHAR(255) NOT NULL,
  `Psicólogo` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `Psicólogo` (`Psicólogo` ASC) VISIBLE,
  CONSTRAINT `Formação_ibfk_1`
    FOREIGN KEY (`Psicólogo`)
    REFERENCES `Planejamente`.`Psicólogo` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
