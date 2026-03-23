-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 23-Mar-2026 às 16:37
-- Versão do servidor: 10.4.6-MariaDB
-- versão do PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ads-m-stéfano`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `consulta`
--

CREATE TABLE `consulta` (
  `CodConv` int(11) NOT NULL,
  `CodPaci` int(11) NOT NULL,
  `CRM` varchar(11) NOT NULL,
  `Data-Hora` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `consulta`
--

INSERT INTO `consulta` (`CodConv`, `CodPaci`, `CRM`, `Data-Hora`) VALUES
(1, 1, '001', '2026-03-23'),
(2, 2, '002', '2026-03-23');

-- --------------------------------------------------------

--
-- Estrutura da tabela `convenio`
--

CREATE TABLE `convenio` (
  `CodConv` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `convenio`
--

INSERT INTO `convenio` (`CodConv`, `Nome`) VALUES
(1, 'Unimed'),
(2, 'Dunimed');

-- --------------------------------------------------------

--
-- Estrutura da tabela `medico`
--

CREATE TABLE `medico` (
  `CRM` varchar(11) NOT NULL,
  `Nome` varchar(40) NOT NULL,
  `Especialização` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `medico`
--

INSERT INTO `medico` (`CRM`, `Nome`, `Especialização`) VALUES
('001', 'Ze Roberto', 'Dermatologista'),
('002', 'Humberto', 'Neurologista'),
('003', 'Dois Berto', 'Cardiologista'),
('004', 'Tres Berto', 'Pediatra');

-- --------------------------------------------------------

--
-- Estrutura da tabela `paciente`
--

CREATE TABLE `paciente` (
  `CodConv` int(11) NOT NULL,
  `CodPaci` int(11) NOT NULL,
  `Nome` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `paciente`
--

INSERT INTO `paciente` (`CodConv`, `CodPaci`, `Nome`) VALUES
(1, 1, 'Jailson Mendes'),
(2, 2, 'Paulo Guina');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `consulta`
--
ALTER TABLE `consulta`
  ADD PRIMARY KEY (`CodConv`,`CodPaci`,`CRM`,`Data-Hora`),
  ADD KEY `consmed` (`CRM`);

--
-- Índices para tabela `convenio`
--
ALTER TABLE `convenio`
  ADD PRIMARY KEY (`CodConv`);

--
-- Índices para tabela `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`CRM`);

--
-- Índices para tabela `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`CodConv`,`CodPaci`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `consulta`
--
ALTER TABLE `consulta`
  ADD CONSTRAINT `consconv` FOREIGN KEY (`CodConv`) REFERENCES `convenio` (`CodConv`),
  ADD CONSTRAINT `conspaci` FOREIGN KEY (`CodConv`,`CodPaci`) REFERENCES `paciente` (`CodConv`, `CodPaci`),
  ADD CONSTRAINT `preventiva` FOREIGN KEY (`CRM`) REFERENCES `medico` (`CRM`);

--
-- Limitadores para a tabela `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `convparapaci` FOREIGN KEY (`CodConv`) REFERENCES `convenio` (`CodConv`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
