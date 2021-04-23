require "spec_helper"

describe Sefazp do
  let(:mdfe_v1_00) { File.open("spec/fixtures/mdfe/mdfe-v1_00.xml", "r") }
  let(:cte_sem_exped_receb_v2_00) { File.open("spec/fixtures/cte/cte-sem-exped-receb-v2_00.xml", "r") }
  let(:cte_com_exped_v2_00) { File.open("spec/fixtures/cte/cte-com-exped-v2_00.xml", "r") }
  let(:cte_com_receb_v2_00) { File.open("spec/fixtures/cte/cte-com-receb-v2_00.xml", "r") }
  let(:cte_com_outros_documentos_v1_04) { File.open("spec/fixtures/cte/cte-com-outros-documentos-v1_04.xml", "r") }
  let(:nfe_v2_00) { File.open("spec/fixtures/nfe/nfe-v2_00.xml", "r") }
  let(:nfe_v3_10) { File.open("spec/fixtures/nfe/nfe-v3_10.xml", "r") }

  describe "v2.00" do
    describe "parse_mdfe" do
      it "should parse a mdfe" do
        expect(Sefazp.parse_mdfe(mdfe_v1_00)).to eq({ :municipio_do_emitente=>"9999999", :municipio_de_destino=>"9999999", :numero=>"2022", :serie=>"1", :chave_de_acesso=>"MDFe35150209494507000113580010000020221000020224", :cnpj_do_emitente=>"99999999999999", :inscricao_estadual_do_emitente=>"999999999999", :nome_do_emitente=>"XXXXXXXXXXX XX XXXXXXXXXXXXXXXXXXXXX XXXXXXXX", :nome_fantasia_do_emitente=>"XXXXXXXXXX XXXXXXXXXA XXXXXXI XXXXXXXXXXXXX", :logradouro_do_emitente=>"XXX XXXXX XXXX", :numero_do_emitente=>"999", :complemento_do_emitente=>"XXXX X", :bairro_do_emitente=>"XXXXXXXX", :cep_do_emitente=>"99999999", :placa_do_veiculo=>"XXX9999", :uf_do_veiculo=>"XX", :nome_do_motorista=>"XXXXXXXXXXXXXX X XXXXX XXXXXXXXX", :cpf_do_motorista=>"99999999999", :emissao=>"2015-02-11T10:09:00", :keys=>["35150209494909090913579910000125281009990011", "35159299994597099113570010099925271099900014"] })
      end
    end

    describe "parse_cte" do
      it "should parse a cte without exped and receb" do
        expect(Sefazp.parse_cte(cte_sem_exped_receb_v2_00)).to eq({ :expedidor=>false, :recebedor=>false, :municipio_do_emitente=>"9999999", :municipio_do_remetente=>"9999999", :municipio_do_destinatario=>"9999999", :municipio_do_expedidor=>nil, :municipio_do_recebedor=>nil, :municipio_de_origem=>"9999999", :municipio_de_destino=>"9999999", :municipio_de_emissao=>"3505708", :numero=>"15424", :serie=>"2", :chave_de_acesso=>"CTe35150110663500000167570020000154241000000014", :tipo_do_cte=>"0", :tipo_do_servico=>"0", :tomador_do_servico=>"0", :forma_de_pagamento=>"0", :codigo_do_cfop=>"6353", :descricao_do_cfop=>"ESTABELECIMENTO COMERCIAL", :cnpj_do_emitente=>"99999999999999", :inscricao_estadual_do_emitente=>"999999999999", :nome_do_emitente=>"XXXXXXXX XXXXXXXXX XXXXXXXXXXXX", :nome_fantasia_do_emitente=>"XXXXXXXXXXXXX XXXXX XXXXXXXX", :logradouro_do_emitente=>"XXX XXXXX XXXX", :numero_do_emitente=>"999", :bairro_do_emitente=>"XXXXX XXXXX", :cep_do_emitente=>"99999999", :cnpj_do_remetente=>"99999999999999", :inscricao_estadual_do_remetente=>"9999999999999", :nome_do_remetente=>"XXX XXXXXX XXX", :logradouro_do_remetente=>"X XXXXXX XX XXXXXX", :numero_do_remetente=>"9999", :bairro_do_remetente=>"XXX XXXXXXXXX", :cep_do_remetente=>"99999999", :cnpj_do_destinatario=>"99999999999999", :inscricao_estadual_do_destinatario=>"999999999999", :nome_do_destinatario=>"XXXXXXXXXX XXX X XXXXXX XXXXXXXXXXXXXXXX", :logradouro_do_destinatario=>"XXX XXXXXXX XXXXXXXXX", :numero_do_destinatario=>"999", :bairro_do_destinatario=>"XXXXXXXXXXX", :cep_do_destinatario=>"99999999", :cnpj_do_expedidor=>nil, :inscricao_estadual_do_expedidor=>nil, :nome_do_expedidor=>nil, :logradouro_do_expedidor=>nil, :numero_do_expedidor=>nil, :bairro_do_expedidor=>nil, :cep_do_expedidor=>nil, :cnpj_do_recebedor=>nil, :inscricao_estadual_do_recebedor=>nil, :nome_do_recebedor=>nil, :logradouro_do_recebedor=>nil, :numero_do_recebedor=>nil, :bairro_do_recebedor=>nil, :cep_do_recebedor=>nil, :produto_predominante=>"VARIOS", :unidade_de_medida=>"PECAS", :quantidade=>"225", :valor_da_mercadoria=>"45677.25", :responsavel=>"0", :valor_total=>"370.68", :valor_a_receber=>"370.68", :base_de_calculo=>"370.68", :aliquota_icms=>"12.00", :valor_icms=>"44.48", :lotacao=>"1", :data_prevista_de_entrega=>"2015-01-21", :tipo_do_veiculo=>"0", :placa_do_veiculo=>"EWJ1042", :uf_do_veiculo=>"XX", :renavan_do_veiculo=>"00547274670", :tara_em_kg_do_veiculo=>"15750", :capacidade_em_kg_do_veiculo=>"0", :capacidade_em_m3_do_veiculo=>"0", :nome_do_motorista=>"XXXXX XXXXXXXX XXXXXX", :cpf_do_motorista=>"99999999999", :rntrc=>"46072566", :emissao=>"2015-01-20T12:49:33", :frete=>"370.68", :pedagio=>"0.00", :outros=>"0.00", :keys=>["31159149929943099384550010009318811007008823"] })
      end

      it "should parse a cte with exped" do
        expect(Sefazp.parse_cte(cte_com_exped_v2_00)).to eq({ :expedidor=>true, :recebedor=>false, :municipio_do_emitente=>"9999999", :municipio_do_remetente=>"3525003", :municipio_do_destinatario=>"3505708", :municipio_do_expedidor=>"3505708", :municipio_do_recebedor=>nil, :municipio_de_origem=>"3525003", :municipio_de_destino=>"3505708", :municipio_de_emissao=>"3505708", :numero=>"13634", :serie=>"2", :chave_de_acesso=>"CTe35141210663500000167570020000136341000000017", :tipo_do_cte=>"0", :tipo_do_servico=>"0", :tomador_do_servico=>"1", :forma_de_pagamento=>"0", :codigo_do_cfop=>"5353", :descricao_do_cfop=>"ESTABELECIMENTO COMERCIAL", :cnpj_do_emitente=>"99999999999999", :inscricao_estadual_do_emitente=>"999999999999", :nome_do_emitente=>"XXXXXXXXXXXXX XXXXXXXXXXX XXXX", :nome_fantasia_do_emitente=>"XXXXXX XXXXXX X XXX XXXXXX X", :logradouro_do_emitente=>"XXX XXXXXXXXXX", :numero_do_emitente=>"999", :bairro_do_emitente=>"XXXXXX XXXX", :cep_do_emitente=>"99999999", :cnpj_do_remetente=>"99999999999999", :inscricao_estadual_do_remetente=>"999999999999", :nome_do_remetente=>"XXX XXXXXXXXXX", :logradouro_do_remetente=>"XXXXXXXXX XXXXXXXXXXXXX", :numero_do_remetente=>"999", :bairro_do_remetente=>"XXXXXXXXXXXXXXX", :cep_do_remetente=>"99999999", :cnpj_do_destinatario=>"99999999999999", :inscricao_estadual_do_destinatario=>"999999999999", :nome_do_destinatario=>"XXXXXXXXXX XXX", :logradouro_do_destinatario=>"XXXXX XXXXXXXXXXXXXXXXXX", :numero_do_destinatario=>"999", :bairro_do_destinatario=>"XX XXXXXX", :cep_do_destinatario=>"99999999", :cnpj_do_expedidor=>"99999999999999", :inscricao_estadual_do_expedidor=>"999999999999", :nome_do_expedidor=>"XXXXXXXXXX XXX", :logradouro_do_expedidor=>"XXXXX XXXXXXXX XXXXXXXXX", :numero_do_expedidor=>"999", :bairro_do_expedidor=>"XXXXXX XXXXXX", :cep_do_expedidor=>"99999999", :cnpj_do_recebedor=>nil, :inscricao_estadual_do_recebedor=>nil, :nome_do_recebedor=>nil, :logradouro_do_recebedor=>nil, :numero_do_recebedor=>nil, :bairro_do_recebedor=>nil, :cep_do_recebedor=>nil, :produto_predominante=>"VARIOS", :unidade_de_medida=>"CAIXA", :quantidade=>"126", :valor_da_mercadoria=>"26908.91", :responsavel=>"0", :valor_total=>"643.64", :valor_a_receber=>"643.64", :base_de_calculo=>"643.64", :aliquota_icms=>"12.00", :valor_icms=>"77.24", :lotacao=>"1", :data_prevista_de_entrega=>"2014-12-13", :tipo_do_veiculo=>"0", :placa_do_veiculo=>"KFM0337", :uf_do_veiculo=>"XX", :renavan_do_veiculo=>"00185619878", :tara_em_kg_do_veiculo=>"0", :capacidade_em_kg_do_veiculo=>"0", :capacidade_em_m3_do_veiculo=>"0", :nome_do_motorista=>"XXXXXXX XXXX XX XXXXX", :cpf_do_motorista=>"99999999999", :rntrc=>"46072566", :emissao=>"2014-12-12T13:40:44", :frete=>"336.01", :pedagio=>"0.00", :outros=>"307.63", :keys=>["35141249327943000201559090909193751005308451", "35141249397949090909550020000193801002879334", "35141249327993909291959020000193771001795565", "35141949397949090909550020000193741002231590", "35141949397943909291959020000193811009208874", "35141299927949090909590020000193791005119437", "35141249397949090201550020909193961004903116", "35141299927943000201559090909193981099499189"] })
      end

      it "should parse a cte with receb" do
        expect(Sefazp.parse_cte(cte_com_receb_v2_00)).to eq({ :expedidor=>false, :recebedor=>true, :municipio_do_emitente=>"9999999", :municipio_do_remetente=>"9999999", :municipio_do_destinatario=>"9999999", :municipio_do_expedidor=>nil, :municipio_do_recebedor=>"9999999", :municipio_de_origem=>"9999999", :municipio_de_destino=>"9999999", :municipio_de_emissao=>"3505708", :numero=>"6726", :serie=>"1", :chave_de_acesso=>"CTe35140910663500000167570010000067261000000017", :tipo_do_cte=>"0", :tipo_do_servico=>"0", :tomador_do_servico=>"0", :forma_de_pagamento=>"0", :codigo_do_cfop=>"5352", :descricao_do_cfop=>"ESTABELECIMENTO INDUSTRIAL", :cnpj_do_emitente=>"99999999999999", :inscricao_estadual_do_emitente=>"999999999999", :nome_do_emitente=>"XXXXXXXXXXXXX XXXXXXXXXXX XXXX.", :nome_fantasia_do_emitente=>"XXXXXXXXXXXXX XXXXXXXXX", :logradouro_do_emitente=>"XXX XXXXXXXXXX", :numero_do_emitente=>"999", :bairro_do_emitente=>"XXXXXM XXXXX", :cep_do_emitente=>"99999999", :cnpj_do_remetente=>"99999999999999", :inscricao_estadual_do_remetente=>"999999999999", :nome_do_remetente=>"XXXXXXXXXX XXXXXXX XXXX", :logradouro_do_remetente=>"XXX XXXXXXXX XXXXXXX XXX XXXXXX", :numero_do_remetente=>"99", :bairro_do_remetente=>"XXXXXX XXXXXX", :cep_do_remetente=>"99999999", :cnpj_do_destinatario=>"99999999999999", :inscricao_estadual_do_destinatario=>"999999999999", :nome_do_destinatario=>"XXXXXX XXXXXXXXXXXXXXX X XXXXXXXXXXXXX XXXXX", :logradouro_do_destinatario=>"XXXX XXXXXX XXXXX XXXX", :numero_do_destinatario=>"999", :bairro_do_destinatario=>"XXXXX XXXX", :cep_do_destinatario=>"99999999", :cnpj_do_expedidor=>nil, :inscricao_estadual_do_expedidor=>nil, :nome_do_expedidor=>nil, :logradouro_do_expedidor=>nil, :numero_do_expedidor=>nil, :bairro_do_expedidor=>nil, :cep_do_expedidor=>nil, :cnpj_do_recebedor=>"99999999999999", :inscricao_estadual_do_recebedor=>"999999999999", :nome_do_recebedor=>"XXXXXXXXXX XXXXXXXX XXXXXX XXXXX XXXX", :logradouro_do_recebedor=>"XXX XXXXXXXXX XXXXXXXXXXXX", :numero_do_recebedor=>"999", :bairro_do_recebedor=>"XX XXXXXXX", :cep_do_recebedor=>"99999999", :produto_predominante=>"PAPEL", :unidade_de_medida=>"PALLETS", :quantidade=>"10", :valor_da_mercadoria=>"3555.84", :responsavel=>"0", :valor_total=>"333.21", :valor_a_receber=>"333.21", :base_de_calculo=>"333.21", :aliquota_icms=>"12.00", :valor_icms=>"39.99", :lotacao=>"1", :data_prevista_de_entrega=>"2014-09-19", :tipo_do_veiculo=>"0", :placa_do_veiculo=>"BTP2474", :uf_do_veiculo=>"SP", :renavan_do_veiculo=>"999999999", :tara_em_kg_do_veiculo=>"0", :capacidade_em_kg_do_veiculo=>"0", :capacidade_em_m3_do_veiculo=>"0", :nome_do_motorista=>"XXXXXX XXXXXXXXXX XXXXXXX", :cpf_do_motorista=>"99999999999", :rntrc=>"46072566", :emissao=>"2014-09-18T20:23:07", :frete=>"304.12", :pedagio=>"29.09", :outros=>"0.00", :keys=>["35140944003911000148959090909690091528272072"] })
      end

      it "should parse a cte with outros documentos" do
        expect(Sefazp.parse_cte(cte_com_outros_documentos_v1_04)).to eq({ :expedidor=>false, :recebedor=>false, :municipio_do_emitente=>"9999999", :municipio_do_remetente=>"9999999", :municipio_do_destinatario=>"4208203", :municipio_do_expedidor=>nil, :municipio_do_recebedor=>nil, :municipio_de_origem=>"9999999", :municipio_de_destino=>"9999999", :municipio_de_emissao=>"3505708", :numero=>"4158", :serie=>"1", :chave_de_acesso=>"CTe35140310663500000167570010000041581000000017", :tipo_do_cte=>"0", :tipo_do_servico=>"0", :tomador_do_servico=>"0", :forma_de_pagamento=>"0", :codigo_do_cfop=>"6352", :descricao_do_cfop=>"ESTABELECIMENTO INDUSTRIAL", :cnpj_do_emitente=>"99999999999999", :inscricao_estadual_do_emitente=>"999999999999", :nome_do_emitente=>"XXXXXXXXXXXXXX XXXXXXXXXX XXXX", :nome_fantasia_do_emitente=>"XXXXX XXXXXXX", :logradouro_do_emitente=>"XXXXXXX XXXXXXXXXX", :numero_do_emitente=>"999", :bairro_do_emitente=>"XXXXXXX XXXX", :cep_do_emitente=>"99999999", :cnpj_do_remetente=>"99999999999999", :inscricao_estadual_do_remetente=>"999999999999", :nome_do_remetente=>"XXXXXXXXXXX XXXXXXXXXXXXXXXX XXXX", :logradouro_do_remetente=>"XXXXXXXXXXXX XXXXXXXXXXX XXXXXX", :numero_do_remetente=>"999", :bairro_do_remetente=>"XXXXXX XXXXXX", :cep_do_remetente=>"99999999", :cnpj_do_destinatario=>"99999999999999", :inscricao_estadual_do_destinatario=>"999999999", :nome_do_destinatario=>"XXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXX XXXX", :logradouro_do_destinatario=>"XXXXXXXX XXXXXXXX XXXXX", :numero_do_destinatario=>"999", :bairro_do_destinatario=>"XXXXXXXXX", :cep_do_destinatario=>"99999999", :cnpj_do_expedidor=>nil, :inscricao_estadual_do_expedidor=>nil, :nome_do_expedidor=>nil, :logradouro_do_expedidor=>nil, :numero_do_expedidor=>nil, :bairro_do_expedidor=>nil, :cep_do_expedidor=>nil, :cnpj_do_recebedor=>nil, :inscricao_estadual_do_recebedor=>nil, :nome_do_recebedor=>nil, :logradouro_do_recebedor=>nil, :numero_do_recebedor=>nil, :bairro_do_recebedor=>nil, :cep_do_recebedor=>nil, :produto_predominante=>"PAPEL", :unidade_de_medida=>"PALLETS", :quantidade=>"1", :valor_da_mercadoria=>"200.00", :responsavel=>"0", :valor_total=>"260.45", :valor_a_receber=>"260.45", :base_de_calculo=>"260.45", :aliquota_icms=>"12.00", :valor_icms=>"31.25", :lotacao=>"1", :data_prevista_de_entrega=>"2014-03-29", :tipo_do_veiculo=>"0", :placa_do_veiculo=>"NPF1148", :uf_do_veiculo=>"XX", :renavan_do_veiculo=>"999999999", :tara_em_kg_do_veiculo=>"0", :capacidade_em_kg_do_veiculo=>"0", :capacidade_em_m3_do_veiculo=>"0", :nome_do_motorista=>"XXXX XXXXXXXX", :cpf_do_motorista=>"99999999999", :rntrc=>"46072566", :emissao=>"2014-03-28T15:33:33", :frete=>"260.45", :pedagio=>"0.00", :outros=>"0.00", :keys=>["000667"] })
      end
    end

    describe "parse_nfe" do
      it "should parse a nfe" do
        expect(Sefazp.parse_nfe(nfe_v2_00)).to eq({ :municipio_do_emitente=>"9999999", :municipio_do_destinatario=>"9999999", :chave_de_acesso=>"35131999998628000112599999000099999414999856", :numero=>"578", :serie=>"1", :natureza_da_operacao=>"OUTRAS SAIDAS OU PRESTACOES DE SERVICO NAO ESPECIFICADAS", :protocolo_de_autorizacao=>"135130715901757 2013-11-22T14:23:28", :cnpj_do_emitente=>"99999999999999", :inscricao_estadual_do_emitente=>"999999999999", :nome_do_emitente=>"XXX XXXXXXXXXXXXX XXXXXXXXXX XXXX", :logradouro_do_emitente=>"XXX XXXXXXXXXXXXXXXXXX XXXXXXXX", :numero_do_emitente=>"999", :bairro_do_emitente=>"XXXXXX XXXXXX", :cep_do_emitente=>"99999999", :telefone_do_emitente=>"9999999999", :documento_do_destinatario=>"99999999999999", :inscricao_estadual_do_destinatario=>"999999999999", :nome_do_destinatario=>"XXXXXXXXX XXXXXXXX XXXXXXXXXXXXXXXXXXXXXXX XXXXX", :logradouro_do_destinatario=>"XXX XXX XXXXXXXXXXX", :numero_do_destinatario=>"999", :bairro_do_destinatario=>"XXXXXX XXXXXX", :cep_do_destinatario=>"99999999", :telefone_do_destinatario=>"9999999999", :data_de_emissao=>"2013-11-22", :data_de_entrada_saida=>"2013-11-22", :hora_de_entrada_saida=>"00:00:00", :base_de_calculo_do_icms=>"0.00", :valor_do_icms=>"0.00", :valor_dos_produtos=>"6531.60", :valor_do_frete=>"0.00", :valor_do_seguro=>"0.00", :valor_do_desconto=>"0.00", :valor_de_outras_despesas=>"0.00", :valor_do_ipi=>"0.00", :valor_total_da_nota=>"6531.60", :cnpj_da_transportadora=>nil, :inscricao_estadual_da_transportadora=>nil, :nome_da_transportadora=>nil, :logradouro_da_transportadora=>nil, :municipio_da_transportadora=>nil, :uf_da_transportadora=>nil, :frete_por_conta=>"9", :placa_do_veiculo=>nil, :uf_do_veiculo=>nil, :quantidade=>"12", :especie=>"pallets", :peso_bruto=>"3580.000", :peso_liquido=>"3151.590", :informacoes_complementares=>"Nao incidencia do ICMS, conforme artigo 7  IX, Decreto n 45490/00  - OC.124283/1  OC.124283/1", :items=>[{"codigo"=>"IE-000063", "descricao"=>"COD  500177-CINTA QUADRADA", "ncm_sh"=>"48191000", "cfop"=>"5949", "unidade"=>"PC", "quantidade"=>"120.0000", "valor_unitario"=>"1.0800000000", "valor_total"=>"129.60", "cst"=>nil, "base_de_calculo_do_icms"=>nil, "valor_do_icms"=>nil, "aliquota_do_icms"=>nil}, {"codigo"=>"IE-000010", "descricao"=>"BANDEJA NO  2 1 - FP", "ncm_sh"=>"48191000", "cfop"=>"5949", "unidade"=>"PC", "quantidade"=>"1650.0000", "valor_unitario"=>"3.8800000000", "valor_total"=>"6402.00", "cst"=>nil, "base_de_calculo_do_icms"=>nil, "valor_do_icms"=>nil, "aliquota_do_icms"=>nil}] })
      end
    end
  end

  describe "v3.10" do
    describe "parse_nfe" do
      it "should parse a nfe" do
        expect(Sefazp.parse_nfe(nfe_v3_10)).to eq({
          :municipio_do_emitente=>"9999999",
          :municipio_do_destinatario=>"9999999",
          :chave_de_acesso=>"35150344656456453664364370003057641002527982",
          :numero=>"305764",
          :serie=>"1",
          :natureza_da_operacao=>"VENDA MERCADORIA PARA INDUSTRIALIZACAO REVENDA  SIPI",
          :protocolo_de_autorizacao=>"135999936184026 2015-03-04T11:43:34-03:00",
          :cnpj_do_emitente=>"99999999999999",
          :inscricao_estadual_do_emitente=>"999999999999",
          :nome_do_emitente=>"XXXXXXXXXX XXX",
          :logradouro_do_emitente=>"XXX XXXXXXXXX XXXXXXXXXX",
          :numero_do_emitente=>"999",
          :bairro_do_emitente=>"XXXXXX XXXXXX",
          :cep_do_emitente=>"99999999",
          :telefone_do_emitente=>"9999999999",
          :documento_do_destinatario=>"99999999999999",
          :inscricao_estadual_do_destinatario=>"999999999999",
          :nome_do_destinatario=>"XXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXX",
          :logradouro_do_destinatario=>"XXXXX XXXXXXXX",
          :numero_do_destinatario=>"999",
          :bairro_do_destinatario=>"XXXXXXXX",
          :cep_do_destinatario=>"99999999",
          :telefone_do_destinatario=>"9999999999",
          :data_de_emissao=>"2015-03-04T11:35:00-03:00",
          :data_de_entrada_saida=>"2015-03-04T11:35:00-03:00",
          :base_de_calculo_do_icms=>"1767.94",
          :valor_do_icms=>"318.23",
          :valor_dos_produtos=>"1467.94",
          :valor_do_frete=>"300.00",
          :valor_do_seguro=>"0",
          :valor_do_desconto=>"0",
          :valor_de_outras_despesas=>"0",
          :valor_do_ipi=>"0",
          :valor_total_da_nota=>"1767.94",
          :cnpj_da_transportadora=>"99999999999999",
          :inscricao_estadual_da_transportadora=>"999999999999",
          :nome_da_transportadora=>"XXXXXXXXXXXXX XXXXXXXXXXX XXXX",
          :logradouro_da_transportadora=>"XXXXXXXX XXXXXXX XX",
          :municipio_da_transportadora=>"XXXXXXX",
          :uf_da_transportadora=>"SP",
          :frete_por_conta=>"0",
          :placa_do_veiculo=>nil,
          :uf_do_veiculo=>nil,
          :quantidade=>"2",
          :especie=>"CHAPAS",
          :peso_liquido=>"42.840",
          :informacoes_complementares=>"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
          :items=>[
            {
              "codigo"=>"XXXXXXXXXX",
              "descricao"=>"POLICARBONATO CHAPA ALVEOLAR CRISTAL 10,0X2100X6000 LEXAN THERMOCLEAR",
              "ncm_sh"=>"39206100",
              "cfop"=>"5102",
              "unidade"=>"PC",
              "quantidade"=>"2.0000",
              "valor_unitario"=>"733.97000000",
              "valor_total"=>"1467.94",
              "valor_do_frete" => "300.00",
              "valor_do_ipi" => nil,
              "valor_do_pis" => "29.17",
              "valor_do_cofins" => "134.36",
              "cst"=>"00",
              "base_de_calculo_do_icms"=>"1767.94",
              "valor_do_icms"=>"318.23",
              "aliquota_do_icms"=>"18.0000",
              "item_valor_total_tributos" => nil,
            }
          ]
        })
      end
    end
  end
end
