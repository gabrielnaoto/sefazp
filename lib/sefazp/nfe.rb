class Nfe
  def initialize(xml_content)
    @document = REXML::Document.new(xml_content)
  end

  def parse
    case @document.elements["nfeProc"].attributes["versao"]
    when "2.00"
      parse_v200
    when "3.10"
      parse_v310
    when "4.00"
      parse_v310
    else
      return nil
    end
  end


  private

  def parse_v200
    begin
      municipio_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/cMun"].get_text.to_s rescue nil
      municipio_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/cMun"].get_text.to_s rescue nil
      chave_de_acesso = @document.elements["nfeProc/protNFe/infProt/chNFe"].get_text.to_s rescue nil
      numero = @document.elements["nfeProc/NFe/infNFe/ide/nNF"].get_text.to_s rescue nil
      serie = @document.elements["nfeProc/NFe/infNFe/ide/serie"].get_text.to_s rescue nil
      natureza_da_operacao = @document.elements["nfeProc/NFe/infNFe/ide/natOp"].get_text.to_s rescue nil
      protocolo_de_autorizacao = "#{@document.elements['nfeProc/protNFe/infProt/nProt'].get_text.to_s} #{@document.elements['nfeProc/protNFe/infProt/dhRecbto'].get_text.to_s}" rescue nil
      cnpj_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/CNPJ"].get_text.to_s rescue nil
      inscricao_estadual_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/IE"].get_text.to_s rescue nil
      nome_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/xNome"].get_text.to_s rescue nil
      logradouro_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/xLgr"].get_text.to_s rescue nil
      numero_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/nro"].get_text.to_s rescue nil
      bairro_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/xBairro"].get_text.to_s rescue nil
      cep_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/CEP"].get_text.to_s rescue nil
      telefone_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/fone"].get_text.to_s rescue nil
      if @document.elements["nfeProc/NFe/infNFe/dest/CNPJ"]
        documento_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/CNPJ"].get_text.to_s rescue nil
        inscricao_estadual_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/IE"].get_text.to_s rescue nil
      else
        documento_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/CPF"].get_text.to_s rescue nil
        inscricao_estadual_do_destinatario = nil
      end
      nome_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/xNome"].get_text.to_s rescue nil
      logradouro_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/xLgr"].get_text.to_s rescue nil
      numero_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/nro"].get_text.to_s rescue nil
      bairro_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/xBairro"].get_text.to_s rescue nil
      cep_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/CEP"].get_text.to_s rescue nil
      telefone_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/fone"].get_text.to_s rescue nil
      data_de_emissao = @document.elements["nfeProc/NFe/infNFe/ide/dEmi"].get_text.to_s rescue nil
      data_de_entrada_saida = @document.elements["nfeProc/NFe/infNFe/ide/dSaiEnt"].get_text.to_s rescue nil
      hora_de_entrada_saida = @document.elements["nfeProc/NFe/infNFe/ide/hSaiEnt"].get_text.to_s rescue nil
      base_de_calculo_do_icms = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vBC"].get_text.to_s rescue nil
      valor_do_icms = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vICMS"].get_text.to_s rescue nil
      valor_dos_produtos = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vProd"].get_text.to_s rescue nil
      valor_do_frete = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vFrete"].get_text.to_s rescue nil
      valor_do_seguro = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vSeg"].get_text.to_s rescue nil
      valor_do_desconto = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vDesc"].get_text.to_s rescue nil
      valor_de_outras_despesas = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vOutro"].get_text.to_s rescue nil
      valor_do_ipi = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vIPI"].get_text.to_s rescue nil
      valor_total_da_nota = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vNF"].get_text.to_s rescue nil
      cnpj_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/CNPJ"].get_text.to_s : nil rescue nil
      inscricao_estadual_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/IE"].get_text.to_s : nil rescue nil
      nome_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/xNome"].get_text.to_s : nil rescue nil
      logradouro_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/xEnder"].get_text.to_s : nil rescue nil
      municipio_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/xMun"].get_text.to_s : nil rescue nil
      uf_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/UF"].get_text.to_s : nil rescue nil
      frete_por_conta = @document.elements["nfeProc/NFe/infNFe/transp/modFrete"].get_text.to_s rescue nil
      placa_do_veiculo = @document.elements["nfeProc/NFe/infNFe/transp/veicTransp"] ? @document.elements["nfeProc/NFe/infNFe/transp/veicTransp/placa"].get_text.to_s : nil rescue nil
      uf_do_veiculo = @document.elements["nfeProc/NFe/infNFe/transp/veicTransp"] ? @document.elements["nfeProc/NFe/infNFe/transp/veicTransp/UF"].get_text.to_s : nil rescue nil
      quantidade = @document.elements["nfeProc/NFe/infNFe/transp/vol/qVol"].get_text.to_s rescue nil
      especie = @document.elements["nfeProc/NFe/infNFe/transp/vol/esp"].get_text.to_s rescue nil
      peso_bruto = @document.elements["nfeProc/NFe/infNFe/transp/vol/pesoB"].get_text.to_s rescue nil
      peso_liquido = @document.elements["nfeProc/NFe/infNFe/transp/vol/pesoL"].get_text.to_s rescue nil
      informacoes_complementares = @document.elements["nfeProc/NFe/infNFe/infAdic/infCpl"].get_text.to_s rescue nil

      items = []
      @document.elements.each('nfeProc/NFe/infNFe/det') do |item|
        prod = item[0]
        imposto = item[1]
        item_codigo = prod.elements['cProd'].get_text.to_s rescue nil
        item_descricao = prod.elements['xProd'].get_text.to_s rescue nil
        item_ncm_sh = prod.elements['NCM'].get_text.to_s rescue nil
        item_cfop = prod.elements['CFOP'].get_text.to_s rescue nil
        item_unidade = prod.elements['uCom'].get_text.to_s rescue nil
        item_quantidade = prod.elements['qCom'].get_text.to_s rescue nil
        item_valor_unitario = prod.elements['vUnCom'].get_text.to_s rescue nil
        item_valor_total = prod.elements['vProd'].get_text.to_s rescue nil
        item_cst = imposto.elements['ICMS/ICMS51/CST'].get_text.to_s rescue nil
        item_base_de_calculo_do_icms = imposto.elements['ICMS/ICMS51/vBC'].get_text.to_s rescue nil
        item_valor_do_icms = imposto.elements['ICMS/ICMS51/vICMS'].get_text.to_s rescue nil
        item_aliquota_do_icms = imposto.elements['ICMS/ICMS51/pICMS'].get_text.to_s rescue nil
        items << { "codigo" => item_codigo, "descricao" => item_descricao, "ncm_sh" => item_ncm_sh, "cfop" => item_cfop, "unidade" => item_unidade, "quantidade" => item_quantidade, "valor_unitario" => item_valor_unitario, "valor_total" => item_valor_total, "cst" => item_cst, "base_de_calculo_do_icms" => item_base_de_calculo_do_icms, "valor_do_icms" => item_valor_do_icms, "aliquota_do_icms" => item_aliquota_do_icms }
      end

      return {
              municipio_do_emitente: municipio_do_emitente,
              municipio_do_destinatario: municipio_do_destinatario,
              chave_de_acesso: chave_de_acesso,
              numero: numero,
              serie: serie,
              natureza_da_operacao: natureza_da_operacao,
              protocolo_de_autorizacao: protocolo_de_autorizacao,
              cnpj_do_emitente: cnpj_do_emitente,
              inscricao_estadual_do_emitente: inscricao_estadual_do_emitente,
              nome_do_emitente: nome_do_emitente,
              logradouro_do_emitente: logradouro_do_emitente,
              numero_do_emitente: numero_do_emitente,
              bairro_do_emitente: bairro_do_emitente,
              cep_do_emitente: cep_do_emitente,
              telefone_do_emitente: telefone_do_emitente,
              documento_do_destinatario: documento_do_destinatario,
              inscricao_estadual_do_destinatario: inscricao_estadual_do_destinatario,
              nome_do_destinatario: nome_do_destinatario,
              logradouro_do_destinatario: logradouro_do_destinatario,
              numero_do_destinatario: numero_do_destinatario,
              bairro_do_destinatario: bairro_do_destinatario,
              cep_do_destinatario: cep_do_destinatario,
              telefone_do_destinatario: telefone_do_destinatario,
              data_de_emissao: data_de_emissao,
              data_de_entrada_saida: data_de_entrada_saida,
              hora_de_entrada_saida: hora_de_entrada_saida,
              base_de_calculo_do_icms: base_de_calculo_do_icms,
              valor_do_icms: valor_do_icms,
              valor_dos_produtos: valor_dos_produtos,
              valor_do_frete: valor_do_frete,
              valor_do_seguro: valor_do_seguro,
              valor_do_desconto: valor_do_desconto,
              valor_de_outras_despesas: valor_de_outras_despesas,
              valor_do_ipi: valor_do_ipi,
              valor_total_da_nota: valor_total_da_nota,
              cnpj_da_transportadora: cnpj_da_transportadora,
              inscricao_estadual_da_transportadora: inscricao_estadual_da_transportadora,
              nome_da_transportadora: nome_da_transportadora,
              logradouro_da_transportadora: logradouro_da_transportadora,
              municipio_da_transportadora: municipio_da_transportadora,
              uf_da_transportadora: uf_da_transportadora,
              frete_por_conta: frete_por_conta,
              placa_do_veiculo: placa_do_veiculo,
              uf_do_veiculo: uf_do_veiculo,
              quantidade: quantidade,
              especie: especie,
              peso_bruto: peso_bruto,
              peso_liquido: peso_liquido,
              informacoes_complementares: informacoes_complementares,
              items: items
              }
    rescue
      return nil
    end
  end

  def parse_v310
    begin
      municipio_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/cMun"].get_text.to_s rescue nil
      municipio_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/cMun"].get_text.to_s rescue nil
      chave_de_acesso = @document.elements["nfeProc/protNFe/infProt/chNFe"].get_text.to_s rescue nil
      numero = @document.elements["nfeProc/NFe/infNFe/ide/nNF"].get_text.to_s rescue nil
      serie = @document.elements["nfeProc/NFe/infNFe/ide/serie"].get_text.to_s rescue nil
      natureza_da_operacao = @document.elements["nfeProc/NFe/infNFe/ide/natOp"].get_text.to_s rescue nil
      protocolo_de_autorizacao = "#{@document.elements['nfeProc/protNFe/infProt/nProt'].get_text.to_s} #{@document.elements['nfeProc/protNFe/infProt/dhRecbto'].get_text.to_s}" rescue nil
      cnpj_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/CNPJ"].get_text.to_s rescue nil
      inscricao_estadual_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/IE"].get_text.to_s rescue nil
      nome_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/xNome"].get_text.to_s rescue nil
      logradouro_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/xLgr"].get_text.to_s rescue nil
      numero_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/nro"].get_text.to_s rescue nil
      bairro_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/xBairro"].get_text.to_s rescue nil
      cep_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/CEP"].get_text.to_s rescue nil
      telefone_do_emitente = @document.elements["nfeProc/NFe/infNFe/emit/enderEmit/fone"].get_text.to_s rescue nil
      if @document.elements["nfeProc/NFe/infNFe/dest/CNPJ"]
        documento_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/CNPJ"].get_text.to_s rescue nil
        inscricao_estadual_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/IE"].get_text.to_s rescue nil
      else
        documento_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/CPF"].get_text.to_s rescue nil
        inscricao_estadual_do_destinatario = nil
      end
      nome_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/xNome"].get_text.to_s rescue nil
      logradouro_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/xLgr"].get_text.to_s rescue nil
      numero_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/nro"].get_text.to_s rescue nil
      bairro_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/xBairro"].get_text.to_s rescue nil
      cep_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/CEP"].get_text.to_s rescue nil
      telefone_do_destinatario = @document.elements["nfeProc/NFe/infNFe/dest/enderDest/fone"].get_text.to_s rescue nil
      data_de_emissao = @document.elements["nfeProc/NFe/infNFe/ide/dhEmi"].get_text.to_s rescue nil
      data_de_entrada_saida = @document.elements["nfeProc/NFe/infNFe/ide/dhSaiEnt"].get_text.to_s rescue nil
      base_de_calculo_do_icms = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vBC"].get_text.to_s rescue nil
      valor_do_icms = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vICMS"].get_text.to_s rescue nil
      valor_dos_produtos = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vProd"].get_text.to_s rescue nil
      valor_do_frete = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vFrete"].get_text.to_s rescue nil
      valor_do_seguro = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vSeg"].get_text.to_s rescue nil
      valor_do_desconto = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vDesc"].get_text.to_s rescue nil
      valor_de_outras_despesas = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vOutro"].get_text.to_s rescue nil
      valor_do_ipi = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vIPI"].get_text.to_s rescue nil
      valor_total_da_nota = @document.elements["nfeProc/NFe/infNFe/total/ICMSTot/vNF"].get_text.to_s rescue nil
      cnpj_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/CNPJ"].get_text.to_s : nil rescue nil
      inscricao_estadual_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/IE"].get_text.to_s : nil rescue nil
      nome_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/xNome"].get_text.to_s : nil rescue nil
      logradouro_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/xEnder"].get_text.to_s : nil rescue nil
      municipio_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/xMun"].get_text.to_s : nil rescue nil
      uf_da_transportadora = @document.elements["nfeProc/NFe/infNFe/transp/transporta"] ? @document.elements["nfeProc/NFe/infNFe/transp/transporta/UF"].get_text.to_s : nil rescue nil
      frete_por_conta = @document.elements["nfeProc/NFe/infNFe/transp/modFrete"].get_text.to_s rescue nil
      placa_do_veiculo = @document.elements["nfeProc/NFe/infNFe/transp/veicTransp"] ? @document.elements["nfeProc/NFe/infNFe/transp/veicTransp/placa"].get_text.to_s : nil rescue nil
      uf_do_veiculo = @document.elements["nfeProc/NFe/infNFe/transp/veicTransp"] ? @document.elements["nfeProc/NFe/infNFe/transp/veicTransp/UF"].get_text.to_s : nil rescue nil
      quantidade = @document.elements["nfeProc/NFe/infNFe/transp/vol/qVol"].get_text.to_s rescue nil
      especie = @document.elements["nfeProc/NFe/infNFe/transp/vol/esp"].get_text.to_s rescue nil
      peso_liquido = @document.elements["nfeProc/NFe/infNFe/transp/vol/pesoL"].get_text.to_s rescue nil
      informacoes_complementares = @document.elements["nfeProc/NFe/infNFe/infAdic/infCpl"].get_text.to_s rescue nil

      items = []
      @document.elements.each('nfeProc/NFe/infNFe/det') do |item|
        prod = item[0]
        imposto = item[1]
        item_codigo = prod.elements['cProd'].get_text.to_s rescue nil
        item_descricao = prod.elements['xProd'].get_text.to_s rescue nil
        item_ncm_sh = prod.elements['NCM'].get_text.to_s rescue nil
        item_cfop = prod.elements['CFOP'].get_text.to_s rescue nil
        item_unidade = prod.elements['uCom'].get_text.to_s rescue nil
        item_quantidade = prod.elements['qCom'].get_text.to_s rescue nil
        item_valor_unitario = prod.elements['vUnCom'].get_text.to_s rescue nil
        item_valor_total = prod.elements['vProd'].get_text.to_s rescue nil
        item_valor_frete = prod.elements['vFrete'].get_text.to_s rescue nil
        item_valor_total_tributos = imposto.elements['vTotTrib'].get_text.to_s rescue nil
        item_valor_ipi = imposto.elements['IPI/IPITrib/vIPI'].get_text.to_s rescue nil
        item_valor_pis = imposto.elements['PIS/PISAliq/vPIS'].get_text.to_s rescue nil
        item_valor_cofins = imposto.elements['COFINS/COFINSAliq/vCOFINS'].get_text.to_s rescue nil

        imposto_icms = imposto.elements['ICMS'].children
        if imposto_icms.any?
          imposto_icms.each do |icms|
            item_origem                   = icms.elements['orig'].get_text.to_s rescue nil
            item_cst                      = icms.elements['CST'].get_text.to_s rescue nil
            item_base_de_calculo_do_icms  = icms.elements['vBC'].get_text.to_s rescue nil
            item_valor_do_icms            = icms.elements['vICMS'].get_text.to_s rescue nil
            item_aliquota_do_icms         = icms.elements['pICMS'].get_text.to_s rescue nil

            items << {
                      "codigo" => item_codigo,
                      "descricao" => item_descricao,
                      "ncm_sh" => item_ncm_sh,
                      "cfop" => item_cfop,
                      "unidade" => item_unidade,
                      "quantidade" => item_quantidade,
                      "valor_unitario" => item_valor_unitario,
                      "valor_total" => item_valor_total,
                      "valor_do_frete" => item_valor_frete,
                      "valor_do_ipi" => item_valor_ipi,
                      "valor_do_pis" => item_valor_pis,
                      "valor_do_cofins" => item_valor_cofins,
                      "cst" => item_cst,
                      "base_de_calculo_do_icms" => item_base_de_calculo_do_icms,
                      "valor_do_icms" => item_valor_do_icms,
                      "aliquota_do_icms" => item_aliquota_do_icms,
                      "item_valor_total_tributos" => item_valor_total_tributos,
                    }
          end
        else
          item_cst = imposto.elements['ICMS/ICMS51/CST'].get_text.to_s rescue nil
          item_base_de_calculo_do_icms = imposto.elements['ICMS/ICMS51/vBC'].get_text.to_s rescue nil
          item_valor_do_icms = imposto.elements['ICMS/ICMS51/vICMS'].get_text.to_s rescue nil
          item_aliquota_do_icms = imposto.elements['ICMS/ICMS51/pICMS'].get_text.to_s rescue nil

          items << {
            "codigo" => item_codigo,
            "descricao" => item_descricao,
            "ncm_sh" => item_ncm_sh,
            "cfop" => item_cfop,
            "unidade" => item_unidade,
            "quantidade" => item_quantidade,
            "valor_unitario" => item_valor_unitario,
            "valor_total" => item_valor_total,
            "valor_do_frete" => item_valor_frete,
            "valor_do_ipi" => item_valor_ipi,
            "valor_do_pis" => item_valor_pis,
            "valor_do_cofins" => item_valor_cofins,
            "cst" => item_cst,
            "base_de_calculo_do_icms" => item_base_de_calculo_do_icms,
            "valor_do_icms" => item_valor_do_icms,
            "aliquota_do_icms" => item_aliquota_do_icms,
            "item_valor_total_tributos" => item_valor_total_tributos,
          }
        end
      end

      return {
              municipio_do_emitente: municipio_do_emitente,
              municipio_do_destinatario: municipio_do_destinatario,
              chave_de_acesso: chave_de_acesso,
              numero: numero,
              serie: serie,
              natureza_da_operacao: natureza_da_operacao,
              protocolo_de_autorizacao: protocolo_de_autorizacao,
              cnpj_do_emitente: cnpj_do_emitente,
              inscricao_estadual_do_emitente: inscricao_estadual_do_emitente,
              nome_do_emitente: nome_do_emitente,
              logradouro_do_emitente: logradouro_do_emitente,
              numero_do_emitente: numero_do_emitente,
              bairro_do_emitente: bairro_do_emitente,
              cep_do_emitente: cep_do_emitente,
              telefone_do_emitente: telefone_do_emitente,
              documento_do_destinatario: documento_do_destinatario,
              inscricao_estadual_do_destinatario: inscricao_estadual_do_destinatario,
              nome_do_destinatario: nome_do_destinatario,
              logradouro_do_destinatario: logradouro_do_destinatario,
              numero_do_destinatario: numero_do_destinatario,
              bairro_do_destinatario: bairro_do_destinatario,
              cep_do_destinatario: cep_do_destinatario,
              telefone_do_destinatario: telefone_do_destinatario,
              data_de_emissao: data_de_emissao,
              data_de_entrada_saida: data_de_entrada_saida,
              base_de_calculo_do_icms: base_de_calculo_do_icms,
              valor_do_icms: valor_do_icms,
              valor_dos_produtos: valor_dos_produtos,
              valor_do_frete: valor_do_frete,
              valor_do_seguro: valor_do_seguro,
              valor_do_desconto: valor_do_desconto,
              valor_de_outras_despesas: valor_de_outras_despesas,
              valor_do_ipi: valor_do_ipi,
              valor_total_da_nota: valor_total_da_nota,
              cnpj_da_transportadora: cnpj_da_transportadora,
              inscricao_estadual_da_transportadora: inscricao_estadual_da_transportadora,
              nome_da_transportadora: nome_da_transportadora,
              logradouro_da_transportadora: logradouro_da_transportadora,
              municipio_da_transportadora: municipio_da_transportadora,
              uf_da_transportadora: uf_da_transportadora,
              frete_por_conta: frete_por_conta,
              placa_do_veiculo: placa_do_veiculo,
              uf_do_veiculo: uf_do_veiculo,
              quantidade: quantidade,
              especie: especie,
              peso_liquido: peso_liquido,
              informacoes_complementares: informacoes_complementares,
              items: items
              }
    rescue
      return nil
    end
  end
end
