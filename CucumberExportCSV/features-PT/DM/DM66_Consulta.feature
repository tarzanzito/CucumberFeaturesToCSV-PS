#language:pt
@DM66-CON
Funcionalidade: DM66 - Consulta - Perfil '999999'

  Fundo: Login na DM66
    Dado login efetuado no TF
    Quando entra na "DM66"
    Então valida que apresenta transacção

  @DM66-CON-01
  Cenário: DM66 - Validar que especifica os campos de entrada caso não se seleccione nada
    Quando clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta a mensagem de erro de local "Deve preencher pelo menos um dos campos Data"
    #Retirar print do ecrã onde seja visível a mensagem local "Deve preencher pelo menos um dos campos Data"
    
  @DM66-CON-02
  Cenário: DM66 - Validar que introduzindo apenas o campo chave [Data Recepção] com uma data inferior ou igual a Data do Dia, a transacção retorna resultados
    Quando preenche o campo chave [Data Recepção] com "2017-01-01"
    E clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    #Retirar print do ecrã de forma a confirmar que a transacção é executada
    
  @DM66-CON-03
  Cenário: DM66 - Validar que introduzindo apenas o campo chave [Data Process.] com uma data inferior ou igual a Data do Dia, a transacção retorna os registos com data igual ou superior à digitada
    Quando preenche o campo chave [Data Process.] com "2017-01-01"
    E clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    E valida que todos os registos apresentam na coluna [Data Processamento] uma data igual ou superior a "2017-01-01"
    #Retirar prints do ecrã de forma a que seja possível verificar todos os registos apresentados na lista e toda a informação apresentada nas diversas colunas
    #O teste vai dar failed porque o filtro não está a funcionar
    
  @DM66-CON-04
  Cenário: DM66 - Validar que introduzindo apenas o campo chave [Data Retorno], a transacção retorna os registos com data superior à digitada
    Quando preenche o campo chave [Data Retorno] com "2010-01-01"
    E clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    E valida que todos os registos apresentam na coluna [Data Retorno] uma data igual ou superior a "2010-01-01"
    #Retirar prints do ecrã de forma a que seja possível verificar todos os registos apresentados na lista e toda a informação apresentada nas diversas colunas
  
  @DM66-CON-05
  Esquema do Cenário: DM66 - Validar que introduzindo apenas os campos chave [Data Retorno] e [Conta], a transacção retorna os registos com data superior à digitada e limita os registos aos associados à Conta introduzida
    Quando preenche o campo chave [Data Retorno] com "2010-01-01"
    E prenche o campo chave [Conta] com "<BalcaoConta>" e com "<Conta>"
    E clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    E valida que todos os registos apresentam na coluna [Data Retorno] uma data igual ou superior a "2010-01-01"
    E valida que todos os registos apresentam na coluna [Conta do Domiciliador] o valor preenchido no campo chave [Conta] com "<BalcaoConta>" e "<Conta>"
    #Retirar prints do ecrã de forma a que seja possível verificar todos os registos apresentados na lista e toda a informação apresentada nas diversas colunas
    #SELECT DISTINCT CKBALCAO, CKNUMCTA
    #FROM DBSTSTX.DMVT09C0_LOTES
    Exemplos: 
      | BalcaoConta | Conta       |
      |        0003 | 14608624020 |
      |        0003 | 23308661020 |
      |        0003 | 54332606020 |

  #@DM66-CON-06
  #Cenário: DM66 - Validar que a combox do campo chave [Cód. Serviço] corresponde à lista de valores da T492
  #Quando clica na lista de valores do campo chave [Cod. Serviço]
  #Então valida que é disponibilizada uma lista de valores
  #Retirar print do ecrã de forma a confirmar os primeiros valores e outro print com os últimos valores da lista de valores
  #E clica no botão [Sair (ESC)]
  #Quando entra na "TB52"
  #Quando preenche o campo chave [Cod. Tabela] com "492"
  #E clica no botão [Consultar F12]
  #Então valida que retorna na coluna [Chave da Tabela]
  #E valida que na coluna [Descrição Abreviada] estão os mesmos valores que os apresentados na lista de valores do campo chave [Cód. Serviço] da DM66
  #Retirar print do ecrã, carregando no F8 de forma a retirar os vários prints de forma a visualizar toda a lista de valores

  # Tarzanzito nota : foram trocadas as validações porque o selenium parece ter um erro  
  @DM66-CON-07
  Esquema do Cenário: DM66 - Validar que introduzindo apenas os campos chave [Data Retorno] e [Cód. Serviço], a transacção retorna os registos com data superior à digitada e limita os registos aos associados ao Código Serviço seleccionado especificado
    Quando preenche o campo chave [Data Retorno] com "2010-01-01"
    E preenche o campo chave [Cód. Serviço] com "<CodigoServico>"
    E clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    E valida que todos os registos apresentam na coluna [Serviço] o valor preenchido no campo chave "<CodigoServico>"
    E valida que todos os registos apresentam na coluna [Data Retorno] uma data igual ou superior a "2010-01-01"
    #Retirar prints do ecrã de forma a que seja possível verificar todos os registos apresentados na lista e toda a informação apresentada nas diversas colunas
    #Preencher o campo chave [Cód. Serviço] com um valor que exista no campo CSERVDOM da DMT09
    #SELECT DISTINCT CSERVDOM
    #FROM DBSTSTX.DMVT09C0_LOTES
    Exemplos: 
      | CodigoServico |
      |            08 |
      |            09 |
      |            10 |
      |            11 |
      |            12 |
      |            64 |

  @DM66-CON-08
  Esquema do Cenário: DM66 - Validar que introduzindo apenas os campos chave [Data Retorno] e [Nº Suporte], a transacção retorna os registos com data superior à digitada e limita os registos aos associados ao Nº Suporte especificado
    Quando preenche o campo chave [Data Retorno] com "2010-05-01"
    E preenche o campo chave [Nº Suporte] com "<N_Suporte>"
    E clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    #E valida que todos os registos apresentam na coluna [Data Retorno] uma data igual ou superior a "2018-05-01"
    E valida que todos os registos apresentam na coluna [Data Retorno] uma data igual ou superior a "2010-05-01"
    E valida que todos os registos apresentam na coluna [Suporte] o valor preenchido no campo chave "<N_Suporte>"
    #Retirar prints do ecrã de forma a que seja possível verificar todos os registos apresentados na lista e toda a informação apresentada nas diversas colunas
    #Preencher o campo chave [Nº Suporte] com um valor que exista no campo ZDOMBAND da DMT09
    #SELECT DISTINCT ZDOMBAND
    #FROM DBSTSTX.DMVT09C0_LOTES
    Exemplos: 
      | N_Suporte |
      |   3005671 |
      |   3005672 |
      |   3005675 |

  @DM66-CON-09
  Esquema do Cenário: DM66 - Validar que introduzindo apenas os campos chave [Data Retorno] e [Cliente], a transacção retorna os registos com data superior à digitada e limita os registos aos associados ao Cliente especificado
    Quando preenche o campo chave [Data Retorno] com "2010-01-01"
    E preenche o campo chave [Cliente] com "<Cliente>"
    E clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    E valida que todos os registos apresentam na coluna [Data Retorno] uma data igual ou superior a "2010-01-01"
    E valida que todos os registos apresentam na coluna [Cliente] o valor igual a "<Cliente>"
    #Retirar prints do ecrã de forma a que seja possível verificar todos os registos apresentados na lista e toda a informação apresentada nas diversas colunas
    #Preencher o campo chave [Cliente] com um valor que exista no campo ZcLiente da DMT09
    #SELECT DISTINCT ZCLIENTE
    #FROM DBSTSTX.DMVT09C0_LOTES
    Exemplos: 
      | Cliente    |
      |      26259 |
      | 3411006140 |
      | 7400190625 |

  @DM66-CON-10
  Esquema do Cenário: DM66 - Validar que introduzindo apenas os campos chave [Data Retorno] e Indicador de Plataforma SEPA / Sintra / Partenon, a transacção retorna os registos com data superior à digitada e limita os registos aos associados ao Tipo de Plataforma seleccionado
    Quando preenche o campo chave [Data Retorno] com "2010-01-01"
    E selecciona o campo chave Indicador [Plataforma] com "<Plataforma>"
    E clica no botão [Consultar F12]
    Então valida que a "DM66" apresenta em rodapé a mensagem "Fim de Consulta - Não há mais Dados"
    E valida que todos os registos apresentam na coluna [Plataforma] o descritivo preenchido com "<Descritivo_Plataforma>"
    E valida que todos os registos apresentam na coluna [Data Retorno] uma data igual ou superior a "2010-01-01"
    #Retirar prints do ecrã de forma a que seja possível verificar todos os registos apresentados na lista e toda a informação apresentada nas diversas colunas
    Exemplos: 
      | Plataforma | Descritivo_Plataforma |
      | SEPA       | SEPA                  |
      | Sintra     | SINTRA                |
      | Partenon   | PARTENÓN              |
