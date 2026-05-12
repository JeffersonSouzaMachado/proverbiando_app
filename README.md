# Proverbiando

Aplicativo mobile desenvolvido em Flutter que exibe provérbios bíblicos de forma simples, limpa e intuitiva.

O objetivo do projeto é praticar e demonstrar uma arquitetura escalável usando Clean Architecture, Riverpod, consumo de API, autenticação anônima com Firebase, persistência de dados no Firestore, observabilidade com Analytics e Crashlytics, além de navegação com deep link.

---

## Sobre o projeto

O **Proverbiando** carrega um provérbio bíblico ao iniciar o aplicativo e permite que o usuário atualize para receber um novo provérbio.

Também é possível salvar provérbios favoritos, que ficam vinculados ao usuário por meio de autenticação anônima com Firebase.

Também é possível remover provérbios salvos na tela de favoritos com o gesto de deslizar para a esquerda e confirmar a exclusão.

Este projeto foi criado com foco em aprendizado, boas práticas e organização de código para servir como portfólio profissional.

---

## Funcionalidades

- Exibir um provérbio bíblico ao abrir o app
- Atualizar o provérbio exibido
- Salvar provérbios favoritos
- Listar provérbios salvos
- Apagar provérbios salvos
- Autenticação anônima com Firebase
- Persistência de dados no Cloud Firestore
- Monitoramento de falhas com Firebase Crashlytics
- Instrumentação de eventos com Firebase Analytics
- Navegação com `GoRouter`
- Suporte a deep link para abrir a área de provérbios salvos
- Tratamento de estados com `AsyncValue`
- Separação de responsabilidades com Clean Architecture

---

## Deep Link

O projeto possui suporte a deep link usando o pacote `app_links`.

### Formato suportado

```text
proverbiando://proverbio/{id}
```

Exemplo:

```text
proverbiando://proverbio/abc123
```

### Comportamento atual

- O app escuta links recebidos com o esquema `proverbiando`
- O host esperado é `proverbio`
- Quando um link válido é recebido, o app navega para a rota `/saved-proverbs`
- O identificador enviado na URL já é lido no listener e exibido em log com `debugPrint`

Hoje o ID recebido ainda não é usado para abrir um item específico na interface. O comportamento implementado neste momento é direcionar o usuário para a tela de provérbios salvos.

### Fluxo da implementação

- `main.dart` envolve a aplicação com `AppLinkListener`
- `AppLinkListener` trata o link inicial e também links recebidos com o app já aberto
- `AppLinkService` encapsula o acesso ao `AppLinks`
- A navegação é feita via `GoRouter`

### Configuração atual por plataforma

#### Android

O projeto já possui `intent-filter` configurado em `android/app/src/main/AndroidManifest.xml` com:

- `scheme`: `proverbiando`
- `host`: `proverbio`

#### iOS

No estado atual, o `Info.plist` não possui configuração de URL scheme para deep link. Isso significa que a implementação documentada está preparada no Flutter e configurada no Android, mas ainda precisa de configuração nativa no iOS para funcionar completamente nessa plataforma.

---

## Tecnologias utilizadas

- Flutter
- Dart
- Riverpod
- Firebase Auth
- Cloud Firestore
- Firebase Analytics
- Firebase Crashlytics
- Dio
- GoRouter
- app_links
- Clean Architecture
- Material Design

---

## Arquitetura

O projeto segue os princípios da **Clean Architecture**, separando responsabilidades em camadas:

```text
lib/
├── core/
│   ├── analytics/
│   ├── deep_link/
│   ├── firebase/
│   ├── routes/
│   └── ...
│
├── features/
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── saved_proverbs/
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
- Implementações de repositories

### Domain

Camada central da aplicação.
Contém as regras de negócio e não depende diretamente de frameworks externos.

Exemplos:

- Entities
- Contratos de repository
- Use cases

### Presentation

Camada responsável pela interface e pelo estado da aplicação.

Exemplos:

- Pages
- Widgets
- Riverpod Notifiers
- Providers

---

## Fluxo principal

O fluxo principal do app funciona assim:

```text
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

---

## Gerenciamento de estado

O projeto utiliza Riverpod para gerenciar dependências e estados assíncronos.

Exemplo de responsabilidades com Riverpod:

- Criar providers de dependência
- Controlar estado de carregamento
- Tratar erros
- Atualizar dados na tela
- Disponibilizar use cases para a camada de apresentação

---

## Firebase

O Firebase é usado para:

- Criar usuário anônimo
- Identificar o usuário atual
- Salvar provérbios favoritos
- Buscar provérbios salvos
- Remover provérbios salvos
- Registrar eventos de uso com Analytics
- Monitorar falhas em tempo de execução com Crashlytics

### Estrutura básica no Firestore

```text
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

---

## Observabilidade

O projeto possui uma camada dedicada para observabilidade, separando telemetria de regras de negócio e mantendo a implementação aberta para novas integrações e novos eventos.

### Analytics

O Firebase Analytics é usado para registrar eventos importantes da experiência do usuário.

Atualmente o app instrumenta eventos relacionados a:

- carregamento inicial de provérbio
- atualização de provérbio
- salvamento de provérbio
- tentativa de salvar um provérbio já salvo
- carregamento da lista de provérbios salvos
- atualização da lista de provérbios salvos
- exclusão de provérbio salvo
- troca de abas no `BottomNavigationBar`
- visualização de telas com `screen_view`

Os nomes dos eventos ficam centralizados para facilitar manutenção e futuras expansões.

### Crashlytics

O Firebase Crashlytics é inicializado na subida da aplicação e recebe:

- erros fatais do Flutter
- erros assíncronos capturados por `runZonedGuarded`
- erros de plataforma capturados por `PlatformDispatcher`

Essa configuração permite evoluir a estratégia de monitoramento sem alterar o fluxo principal da aplicação.

### Estrutura atual

A implementação foi organizada para permitir evolução sem espalhar chamadas de SDK pela interface:

- `core/analytics/analytics_events.dart`: centraliza os nomes dos eventos
- `core/analytics/analytics_service.dart`: define a abstração de telemetria
- `core/analytics/firebase_analytics_service.dart`: implementa o envio para Firebase Analytics
- `core/analytics/analytics_provider.dart`: expõe a dependência via Riverpod
- `main.dart`: inicializa o Crashlytics e registra handlers globais de erro

Esse formato facilita:

- adicionar novos eventos sem alterar a arquitetura
- trocar a implementação de telemetria no futuro
- manter widgets e notifiers desacoplados do SDK
- expandir a documentação conforme novas features forem instrumentadas

---

## Consumo de API

O app consome dados de uma API para buscar provérbios bíblicos aleatórios.

A camada de datasource é responsável por lidar com a resposta externa, enquanto a conversão para entidades internas acontece antes dos dados chegarem à interface.

---

## Conceitos praticados

Este projeto demonstra conhecimento em:

- Clean Architecture
- Separação de responsabilidades
- Inversão de dependência
- Repository Pattern
- Use cases
- Riverpod Providers
- AsyncNotifier
- AsyncValue
- Consumo de API com Dio
- Firebase Authentication
- Firestore
- Firebase Analytics
- Firebase Crashlytics
- Deep linking
- Observabilidade
- Organização por features
- Estrutura escalável para projetos Flutter

---

## Como executar o projeto

1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/proverbiando.git
```

2. Acesse a pasta do projeto

```bash
cd proverbiando
```

3. Instale as dependências

```bash
flutter pub get
```

4. Configure o Firebase

Este projeto utiliza Firebase. Antes de executar, configure o Firebase no projeto Flutter:

```bash
flutterfire configure
```

Também é necessário habilitar no Firebase Console:

- Authentication anônima
- Cloud Firestore
- Analytics
- Crashlytics

5. Execute o app

```bash
flutter run
```

---

## Status do projeto

Projeto em desenvolvimento.

### Funcionalidades já implementadas

- Buscar provérbio aleatório
- Exibir provérbio na tela inicial
- Atualizar provérbio
- Autenticação anônima
- Salvar provérbio no Firestore
- Buscar provérbios salvos
- Apagar provérbio salvo
- Eventos com Firebase Analytics
- Captura de falhas com Firebase Crashlytics
- Navegação com GoRouter
- Recebimento de deep link no Android

### Próximos passos

- Usar o ID do deep link para abrir um conteúdo específico
- Finalizar configuração de deep link no iOS
- Melhorar tratamento de erros
- Adicionar feedback visual com Toast
- Adicionar testes
- Melhorar UI/UX
- Preparar versão final para publicação

---

## Objetivo como portfólio

Este projeto foi desenvolvido para demonstrar domínio em Flutter moderno, arquitetura limpa e integração com serviços externos.

Além da interface, o foco principal está na organização do código, separação de responsabilidades e aplicação de boas práticas para criar uma base escalável e de fácil manutenção.

---

## Autor

Desenvolvido por Jefferson Machado.

LinkedIn: https://www.linkedin.com/in/thedevjeff  
GitHub: https://github.com/JeffersonSouzaMachado  
WhatsApp: +551298821-5064
