-------------------------------- English --------------------------------
# Areco Project

## Description
The Areco Project is a Delphi application that allows you to save and read connection settings for a PostgreSQL database from an XML file. This project demonstrates how to use FireDAC components to manage database connections and how to manipulate XML files to store settings. Its main functionality is to register products.

## Functionalities
- Save connection settings (DriverName, Database, Server, Port) to an XML file.
- Read connection settings from an XML file.
- Check for the existence of tables in the PostgreSQL database.

## Prerequisites
- Delphi (recommended version: Delphi 10.4 Sydney or higher)
- FireDAC
- PostgreSQL

## How to use
1. First, the "postgres" database must be created in pgAdmin.
2. It is recommended to use a master user when logging in to manipulate the created table.
3. When running the application, the first screen for configuring the application's connection to the database will be displayed. You will need to enter the name of the desired database, port and server for the automatic creation of the "productreg" table that will be used.
4.  Within the already configured application, it is possible to register a product by navigating through the menu (Register\Products), on the "Add" button.
5.  To edit, it is necessary to select the record and click on the "Edit" button.
6. To delete a record, simply select it and click on "Delete".
7. In the "Settings" option in the menu, it is possible to reconfigure the application's connection with the database, and it may be possible to change, for example, the database.
8. To close the application, simply click on "Exit"
9. It is essential to access the application with the same user who owns the "productreg" table created.


-------------------------------- Portugûes --------------------------------
# Areco Project

## Descrição
O Areco Project é uma aplicação Delphi que permite salvar e ler configurações de conexão de um banco de dados PostgreSQL a partir de um arquivo XML. Este projeto demonstra como utilizar componentes FireDAC para gerenciar conexões de banco de dados e como manipular arquivos XML para armazenar configurações. Sua principal funcionalidade é de registrar produtos.

## Funcionalidades
- Salvar configurações de conexão (DriverName, Database, Server, Port) em um arquivo XML.
- Ler configurações de conexão de um arquivo XML.
- Verificar a existência de tabelas no banco de dados PostgreSQL.

## Pré-requisitos
- Delphi (versão recomendada: Delphi 10.4 Sydney ou superior)
- FireDAC
- PostgreSQL

## Como usar
1. Primeiramente deverá está criado o banco de dados "postgres" no pgAdmin.
2. Recomendado utilizar um usuário master ao logar para manipulação da tabela criada.
3. Ao executar a aplicação, será exibida a primeira tela de configuração de conexão da aplicação com o banco, será necessário inserir o nome do database desejado, port e o server para a criação automática da tabela "productreg" que será usada.
4. Dentro da aplicação já configurada, é possível cadastrar um produto navegando pelo menu em (Register\ Products), no botão "Add".
5. Para editar, é necessário selecionar o registro e clicar no botão "Edit".
6. Para deletar um registro basta selecionar o mesmo e clicar em "Delete".
7. Na opção "Settings" no menu é possível reconfigurar a conexão da aplicação com o banco, podendo ser possível alterar como por exemplo, o database.
8. Para encerrar a aplicação basta clicar em "Exit"
9. É imprescindível acessar a aplicação com o mesmo usuário owner da tabela "productreg" criada.
