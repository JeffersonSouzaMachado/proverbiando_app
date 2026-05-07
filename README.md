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