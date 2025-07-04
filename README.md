# psy_agenda

**Aluno:** Klaus Lübe Paixão
**Email:** klauslube93@gmail.com

## Sobre o projeto

Projeto desenvolvido como parte do MBA on Rails e projeto pessoal, com foco na criação de uma aplicação web para gestão de agendamentos entre psicólogos e pacientes. O sistema disponibiliza API REST para cadastro, consulta e gerenciamento dos agendamentos, além de funcionalidades para verificar horários disponíveis, enviar notificações por e-mail, entre outras.

---

## Tecnologias Utilizadas

- Ruby 3.2.x  
- Ruby on Rails 7.2.x  
- PostgreSQL  
- Sidekiq + Redis (para background jobs)  
- ActiveJob (para gerenciamento dos jobs)  
- Letter Opener (para visualizar emails no ambiente de desenvolvimento)  
---

## Como rodar o projeto localmente

```bash
# Clonar o repositório
git clone https://github.com/klaus/psy_agenda.git
cd psy_agenda

# abra o VSCode
# Inicie o projeto dentro do dev container

# Instalar dependências
bundle install

# Preparar o banco de dados
rails db:create
rails db:migrate
rails db:seed

# Iniciar o servidor
rails server
```

---

## Utilização da API (exemplo CURL)

```bash
AGENDAR SESSÃO

curl -X POST http://localhost:3000/api/v1/appointments \
  -H "Content-Type: application/json" \
  -d '{
    "appointment": {
      "psychologist_id": 1,
      "patient_id": 2,
      "start_session": "2025-07-25T14:00:00-03:00",
      "end_session": "2025-07-25T15:00:00-03:00"
    }
  }'


  VERIFICAR HORARIOS DE PSICOLOGO
  curl http://localhost:3000/api/v1/psychologists/1/available_appointments?date=2025-07-05
```

---

## Funcionalidades implementadas

- CRUD de agendamentos (appointments)  
- Consulta de horários disponíveis por psicólogo e data  
- Validação de conflitos de horários e dados (ex: paciente e psicólogo diferentes)  
- Envio de notificações por e-mail antes das consultas (background job com Sidekiq)  
- Configuração e uso de cache para otimização das consultas de horários disponíveis  
- API REST estruturada em namespace `/api/v1`  

---

## Conceitos aplicados
Abaixo estão os conceitos aprendidos em aula e aplicados neste projeto, junto com a justificativa de sua utilização:

1. **API Namespaces**  
   - **Aplicação:** Organização das rotas e controllers dentro do namespace `Api::V1`, permitindo versionamento e melhor estruturação da API.  
   - **Justificativa:** Facilita a manutenção e evolução da API sem impactar consumidores de versões anteriores.

2. **Service Objects**  
   - **Aplicação:** Classe `ScheduleAppointment` encapsula toda a lógica de criação de agendamentos: validação de conflito de horários, distinção entre paciente e psicólogo.  
   - **Justificativa:** Mantém controllers e models enxutos, centraliza regras complexas em um único lugar, facilita testes unitários e promove reutilização de código.

3. **Query Objects**  
   - **Aplicação:** Classe `AvailableAppointmentsQuery` abstrai a construção da consulta de horários disponíveis para um psicólogo em um dia específico, lidando com lógica de intervalos e checagem de conflitos.  
   - **Justificativa:** Separa lógica de consulta do model, tornando o código mais legível e testável, e permitindo composição de consultas reutilizáveis.

4. **Caching (Rails.cache)**  
   - **Aplicação:** No `AvailableAppointmentsQuery`, usamos `Rails.cache.fetch` para armazenar resultados por 10 minutos, evitando recálculos frequentes.  
   - **Justificativa:** Aumenta performance de endpoints que consultam dados estáticos por curtos períodos, reduzindo carga no banco de dados.

5. **Background Jobs (ActiveJob + Sidekiq)**  
   - **Aplicação:** `NotifyUpcomingAppointmentJob` agenda o envio de e-mail de lembrete via `AppointmentMailer`, executado uma hora antes da sessão.  
   - **Justificativa:** Processos demorados, como envio de e-mails, são executados assincronamente, evitando bloqueio de requisições HTTP e melhorando UX.

6. **Mailer e Email Templates**  
   - **Aplicação:** `AppointmentMailer#upcoming_appointment` define o e-mail HTML e texto enviados ao paciente antes da sessão.  
   - **Justificativa:** Implementa comunicação eficaz com o usuário, aproveitando views de e-mail para separar lógica de backend e apresentação.

7. **Timezone e Internacionalização**  
   - **Aplicação:** Configuração do timezone para `America/Sao_Paulo` em `application.rb`, garantindo coerência na exibição e agendamento de horários.  
   - **Justificativa:** Essencial para aplicações que lidam com datas e horários em fusos específicos, evitando confusões e inconsistências.

---

## Próximos passos / melhorias planejadas

- Implementação de autenticação via devise
- Testes automatizados completos (RSpec)
- Notificações por SMS
- Criar front-end inicial

---

Qualquer dúvida ou sugestão, estou à disposição!

---

**Klaus Lübe Paixão**