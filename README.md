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

1. **API Namespaces**  
   Organização das rotas e controllers via namespace, facilitando versionamento da API.

2. **Service Objects**  
   Lógica de agendamento encapsulada em service (`ScheduleAppointment`) para separar regras de negócio da camada controller/model.

3. **Query Objects**  
   Implementação da busca dos horários disponíveis em query object (`AvailableAppointmentsQuery`), isolando a complexidade da consulta.

4. **Background Jobs (ActiveJob + Sidekiq)**  
   Envio de emails agendados via jobs assíncronos para não bloquear a resposta da API.

5. **Cache**  
   Utilização do cache de memória para armazenar resultados frequentes, melhorando performance.

6. **Mailer**  
   Configuração do sistema de envio de emails com views em HTML e texto, integrando com jobs para envio programado.

7. **Timezone e Internacionalização**  
   Configuração do timezone para "Brasilia" garantindo coerência nos horários do sistema.

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