# Desafio de API da BossaBox

  - [Desafio de API da BossaBox](#Desafio)
    - [Requisitos](#requisitos)
    - [Tecnologias](#tecnologias)
    - [Estrutura](#estrutura)
      - [Router](#router)
      - [Controllers](#controllers)
      - [Ecto](#ecto)
      - [Routes](#routes)
    - [Diagrama da API (blueprint)](/apiblueprint.md)
     - [License](#license)


Esse é um desafio de api da BossaBox para começar no site, é necessário criar um CRUD(Create, Read, Update, Delete) de ferramentas de desenvolvimento, que terão os atributos title, link, description e tags.

## Requisitos

* É necessário ter instalado o Elixir e PostgreSQL na máquina;
* Após fazer o clone do  projeto faça `mix deps.get` que irá instalar as dependências do projeto;
* Rode o comando `mix ecto.migrate` que irá atualizar o banco de dados;
* Por mix, o comando `mix phx.server` deve iniciar o projeto;

## Tecnologias

* [Elixir](https://elixir-lang.org/)
* [Phoenix](https://www.phoenixframework.org/)
* [PostgreSQL](https://www.postgresql.org/docs/)

## Estrutura

O projeto é separado em: Router, Controllers, .

### Router

Router vai ser o responsável por habilitar as rotas disponíveis na aplicação, além de configurar quais plugins eu vou usar.

* Para essa aplicação, eu gerei um pipeline chamado api que vai aceitar requests no formato json
* Em sequência eu gero um escopo `/tools` que define que as rotas aceitas serão as com "/tools", utilizando a função resources, eu defino que em /tools será aceito vários tipos de requisições, no caso, estou usando as rotas :create(POST), :index(GET), :show(GET /id), :delete(DELETE /id), :update([PUT /id, PATCH /id]), e direcionando para serem tratadas no ToolController

### Controllers

Controller vai ser responsável por tratar cada requisição, que é encaminhada para uma função baseado em quais parametros foram enviados e qual tipo de requisição, para tratar essas requisições, cada uma dessas funções encaminhar para um serviço próprio

### Ecto

Cada serviço próprio vai fazer uma ação no banco de dados, e é usado o Ecto para isso, o Ecto precisa de o que é chamado de Changeset que vai verificar se os dados preparados para inserir no banco de dados estão corretos

### Diagrama da API

Clique [aqui](apiblueprint.md) para acessar o diagrama da API

### License

[MIT](LICENSE)
