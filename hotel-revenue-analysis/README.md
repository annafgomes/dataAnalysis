<p align="right">
 <a href="README.en.md">🇺🇸 English</a> | <a href="README.md">🇧🇷 Português</a>
  
</p>


# 🏨 Hotel Revenue & Cancellation Analysis

Projeto de **Análise de Dados e Business Intelligence** aplicado ao setor hoteleiro, utilizando **SQL Server** para modelagem e preparação dos dados e **Power BI** para visualização e análise exploratória.

O objetivo é entender padrões de **reservas**, **cancelamentos**, **receita**, **sazonalidade** e **perfil dos clientes** apoiando decisões estratégicas de negócio.

Observou-se a necessidade de analisar com mais detalhes o cancelamento, visto que a taxa de cancelamento passa dos 20%. 

---

## 🎯 Objetivo do Projeto

Responder perguntas como:
- Quais períodos geram maior receita?
- Quais períodos de maior cancelamento?
- Qual o desempenho entre **City Hotel** e **Resort Hotel**?
- Quais países e segmentos trazem mais reservas?
- Existem padrões sazonais claros ao longo dos meses?

---

## 📐 KPIs Principais

Os indicadores foram calculados com foco em **reservas não canceladas**, quando aplicável:

- **Receita Líquida (Net Revenue)**
- **Receita Bruta (Gross Revenue)**
- **Taxa de Cancelamento**
- **ADR (Average Daily Rate)**
- **Total de Reservas**


Esses KPIs permitem análises comparativas, temporais e segmentadas.

---


## 🗂️ Fonte de Dados

Base de dados histórica de reservas hoteleiras (2018–2020), composta por:
- Tabelas anuais (`2018`, `2019`, `2020`)
- Tabelas auxiliares:
  - `meal_cost`
  - `market_segment`

Cada linha representa **uma reserva**.

---

## 🏗️ Modelagem de Dados

### 📌 Estratégia adotada
Foi criado uma **tabela de fato**, com foco em performance e clareza analítica no Power BI.

### ⭐ Tabela Fato
**`fact_hotel_reservations`**

Consolida todas as reservas em uma única tabela, contendo:
- Métricas (receita, hóspedes, noites)
- Atributos de negócio (hotel, país, segmento)
- Colunas temporais tratadas

Essa abordagem evita múltiplas tabelas anuais e facilita análises históricas.

---

## 📅 Tratamento Temporal

Apesar de os dados originais possuírem:
- Ano (texto numérico)
- Mês (texto em inglês)
- Dia (inteiro)

Foi criada uma **coluna de data completa (`arrival_date`)**, garantindo:
- Ordenação cronológica correta
- Uso direto em gráficos de linha
- Compatibilidade total com filtros temporais no Power BI

> ⚠️ A conversão de mês textual foi feita via `CASE WHEN`, evitando problemas de idioma no SQL Server.



---

## 📊 Visualizações no Power BI

Exemplos de análises desenvolvidas:
- 📈 Line Chart Temporal por KPIs e tipo de hotel
- 🏨 Bar Chart por tipo de hotel e anos
- 🌍 Top países por número de reservas
- 🛒 Bar Chart KPIs por segmento de mercado
- 🔀 Funnel Chart Canal de Distribuição KPIs
- 💰 Donut Chart Analíse de descontos

Foi utilizado **seleção de ano**, limitado ao período disponível (2018, 2019, 2020).

---

## 🛠️ Ferramentas Utilizadas

- **SQL Server**
  - CTEs
  - JOINs
  - Funções de data
  - Criação de tabela fato
- **Power BI**
  - Modelagem
  - DAX para KPIs
  - Visualizações interativas

---




