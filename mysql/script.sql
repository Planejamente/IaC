SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema planejamente
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `planejamente` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `planejamente`;

-- Table psicologo
CREATE TABLE IF NOT EXISTS `psicologo` (
  `id` CHAR(36) NOT NULL,
  `crp` VARCHAR(45) NULL,
  `cnpj` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- Table endereco
CREATE TABLE IF NOT EXISTS `endereco` (
  `id` CHAR(36) NOT NULL,
  `numero` INT NOT NULL,
  `cep` CHAR(8) NOT NULL,
  `rua` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- Table usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` CHAR(36) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `sal` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `data_de_nascimento` DATE NOT NULL,
  `telefone` VARCHAR(255) NOT NULL,
  `endereco_id` CHAR(36) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `psicologo_id` CHAR(36) NULL,
  PRIMARY KEY (`id`),
  INDEX `endereco` (`endereco_id` ASC) VISIBLE,
  INDEX `fk_usuario_psicologo1_idx` (`psicologo_id` ASC) VISIBLE,
  CONSTRAINT `paciente_ibfk_10`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `endereco` (`id`),
  CONSTRAINT `fk_usuario_psicologo1`
    FOREIGN KEY (`psicologo_id`)
    REFERENCES `psicologo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- Table consulta
CREATE TABLE IF NOT EXISTS `consulta` (
  `id` CHAR(36) NOT NULL,
  `data_hora_inicio` DATETIME NOT NULL,
  `data_hora_fim` DATETIME NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `observacoes` VARCHAR(255) NOT NULL,
  `psicologo_id` CHAR(36) NOT NULL,
  `link` VARCHAR(255) NOT NULL,
  `usuario_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `psicologo` (`psicologo_id` ASC) VISIBLE,
  INDEX `fk_consulta_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `consulta_ibfk_2`
    FOREIGN KEY (`psicologo_id`)
    REFERENCES `psicologo` (`id`),
  CONSTRAINT `fk_consulta_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- Table arquivos
CREATE TABLE IF NOT EXISTS `arquivos` (
  `id` CHAR(36) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `tamanho` INT NOT NULL,
  `extensao` VARCHAR(255) NOT NULL,
  `consulta_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `consulta` (`consulta_id` ASC) VISIBLE,
  CONSTRAINT `arquivos_ibfk_1`
    FOREIGN KEY (`consulta_id`)
    REFERENCES `consulta` (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- Table avaliacao
CREATE TABLE IF NOT EXISTS `avaliacao` (
  `id` CHAR(36) NOT NULL,
  `consulta_id` CHAR(36) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `usuario_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `consulta` (`consulta_id` ASC) VISIBLE,
  INDEX `fk_avaliacao_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `avaliacao_ibfk_1`
    FOREIGN KEY (`consulta_id`)
    REFERENCES `consulta` (`id`),
  CONSTRAINT `fk_avaliacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- Table especialidade
CREATE TABLE IF NOT EXISTS `especialidade` (
  `id` CHAR(36) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- Table especialidade_psicologo
CREATE TABLE IF NOT EXISTS `especialidade_psicologo` (
  `id` CHAR(36) NOT NULL,
  `especialidade_id` CHAR(36) NOT NULL,
  `psicologo_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `especialidade` (`especialidade_id` ASC) VISIBLE,
  INDEX `psicologo` (`psicologo_id` ASC) VISIBLE,
  CONSTRAINT `especialidadepsicologo_ibfk_1`
    FOREIGN KEY (`especialidade_id`)
    REFERENCES `especialidade` (`id`),
  CONSTRAINT `especialidadepsicologo_ibfk_2`
    FOREIGN KEY (`psicologo_id`)
    REFERENCES `psicologo` (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


-- Table experiencia_formacao
CREATE TABLE IF NOT EXISTS `experiencia_formacao` (
  `id` CHAR(36) NOT NULL,
  `datainicio` DATE NOT NULL,
  `datafim` DATE NULL DEFAULT NULL,
  `instituicao` VARCHAR(255) NOT NULL,
  `cargo` VARCHAR(255) NULL,
  `descricao` VARCHAR(255) NOT NULL,
  `psicologo_id` CHAR(36) NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `titulo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `psicologo` (`psicologo_id` ASC) VISIBLE,
  CONSTRAINT `experiencia_ibfk_1`
    FOREIGN KEY (`psicologo_id`)
    REFERENCES `psicologo` (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
