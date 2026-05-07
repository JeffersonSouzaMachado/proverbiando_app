# Proverbiando

Aplicativo mobile desenvolvido em Flutter que exibe provérbios bíblicos de forma simples, limpa e intuitiva.  
O objetivo do projeto é praticar e demonstrar uma arquitetura escalável usando **Clean Architecture**, **Riverpod**, consumo de API, autenticação anônima com Firebase e persistência de dados no Firestore.

---

## Sobre o projeto

O **Proverbiando** carrega um provérbio bíblico ao iniciar o aplicativo e permite que o usuário atualize para receber um novo provérbio.  
Também é possível salvar provérbios favoritos, que ficam vinculados ao usuário através de autenticação anônima do Firebase.

Este projeto foi criado com foco em aprendizado, boas práticas e organização de código para servir como portfólio profissional.

---

## Funcionalidades

- Exibir um provérbio bíblico ao abrir o app
- Atualizar o provérbio exibido
- Salvar provérbios favoritos
- Listar provérbios salvos
- Autenticação anônima com Firebase
- Persistência de dados no Cloud Firestore
- Tratamento de estados com `AsyncValue`
- Separação de responsabilidades com Clean Architecture

---

## Tecnologias utilizadas

- **Flutter**
- **Dart**
- **Riverpod**
- **Firebase Auth**
- **Cloud Firestore**
- **Dio**
- **Clean Architecture**
- **Material Design**
- **GoRouter** *(em evolução no projeto)*

---

## Arquitetura

O projeto segue os princípios da **Clean Architecture**, separando responsabilidades em camadas:

```text
lib/
├── core/
│   ├── firebase/
│   ├── http/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── home/
│   │   ├── data/
│   │   │   ├── datasource/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   │
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   └── saved_proverbs/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```


## Como a arquitetura funciona
### Data

Responsável por buscar e salvar dados em fontes externas, como API e Firebase.

Exemplos:

- Datasources
- Models
- Implementações dos repositories


### Domain

Camada central da aplicação.
Contém as regras de negócio e não depende diretamente de frameworks externos.

Exemplos:

- Entities
- Repository contracts
- UseCases 


### Presentation

Camada responsável pela interface e pelo estado da aplicação.

Exemplos:

- Pages
- Widgets
- Riverpod Notifiers
- Providers


## Fluxo principal

O fluxo principal do app funciona assim:

```
UI
↓
Notifier / Provider
↓
UseCase
↓
Repository
↓
Datasource
↓
API ou Firebase
```

Esse fluxo mantém o código organizado, testável e com baixo acoplamento entre as camadas.

## Gerenciamento de estado

O projeto utiliza Riverpod para gerenciar dependências e estados assíncronos.

Exemplo de responsabilidades com Riverpod:

- Criar providers de dependências
- Controlar estado de carregamento
- Tratar erros
- Atualizar dados na tela
- Disponibilizar use cases para a camada de apresentação

## Firebase

O Firebase é usado para:

- Criar usuário anônimo
- Identificar o usuário atual
- Salvar provérbios favoritos
- Buscar provérbios salvos

### Estrutura básica no Firestore:

```
users/
└── userId/
    ├── createdAt
    ├── isAnonymous
    ├── lastSeen
    └── savedProverbs/
        └── proverbId/
            ├── text
            ├── reference
            ├── version
            └── addedAt
```

## Consumo de API

O app consome dados de uma API para buscar provérbios bíblicos aleatórios.

A camada de datasource é responsável por lidar com a resposta externa, enquanto a conversão para entidades internas acontece antes dos dados chegarem à interface.

## Conceitos praticados

Este projeto demonstra conhecimento em:

- Clean Architecture
- Separação de responsabilidades
- Inversão de dependência
- Repository Pattern
- UseCases
- Riverpod Providers
- AsyncNotifier
- AsyncValue
- Consumo de API com Dio
- Firebase Authentication
- Firestore
- Organização de features
- Estrutura escalável para projetos Flutter

## Como executar o projeto
1. Clone o repositório  
```git clone https://github.com/seu-usuario/proverbiando.git```
2. Acesse a pasta do projeto  
```cd proverbiando```
3. Instale as dependências  
```flutter pub get```
4. Configure o Firebase

Este projeto utiliza Firebase.
Antes de executar, configure o Firebase no projeto Flutter:  

```flutterfire configure```

Também é necessário habilitar no Firebase Console:

Authentication anônima
Cloud Firestore
5. Execute o app  
```flutter run```
6. 
## Status do projeto

Projeto em desenvolvimento.

Funcionalidades já implementadas:

- Buscar provérbio aleatório
- Exibir provérbio na tela inicial
- Atualizar provérbio
- Autenticação anônima
- Salvar provérbio no Firestore
- Buscar provérbios salvos

Próximos passos:

- Melhorar navegação com GoRouter
- Criar tela completa de provérbios favoritos
- Adicionar feedback visual com Toast
- Melhorar tratamento de erros
- Adicionar testes
- Melhorar UI/UX
- Preparar versão final para publicação
- Objetivo como portfólio

Este projeto foi desenvolvido para demonstrar domínio em Flutter moderno, arquitetura limpa e integração com serviços externos.

Além da interface, o foco principal está na organização do código, separação de responsabilidades e aplicação de boas práticas para criar uma base escalável e de fácil manutenção.

Autor

Desenvolvido por Jefferson Machado.

LinkedIn: https://www.linkedin.com/in/thedevjeff  
GitHub: https://github.com/JeffersonSouzaMachado