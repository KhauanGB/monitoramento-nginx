Monitoramento de Serviço Nginx no WSL com Git Versionamento

1. Introdução
Este projeto configura um ambiente Linux no Windows usando o WSL (Windows Subsystem for Linux) e automatiza o monitoramento do serviço Nginx, com logs registrados a cada 5 minutos. A documentação cobre desde a instalação do ambiente, configuração do Nginx, criação de um script de monitoramento, automação com cron e versionamento com Git.

2. Ambiente Linux no Windows (WSL)
  2.1. Instalação do WSL
   Abra o PowerShell como Administrador e execute:

		wsl --install

   Reinicie o computador quando solicitado.
   Após a reinicialização, o Ubuntu será automaticamente instalado. Siga as instruções para criar um nome de usuário e senha.

  2.2. Verificação e Atualização do WSL
   Verifique a versão do WSL com:

		wsl --list --verbose

   Para atualizar o WSL e usar o Ubuntu:

		wsl --set-version Ubuntu

3. Instalação e Configuração do Nginx
  3.1. Instalação do Nginx

   Atualize os pacotes e instale o Nginx:

		sudo apt update
		sudo apt install nginx

   Inicie o Nginx e verifique se ele está rodando:

		sudo systemctl start nginx
		sudo systemctl status nginx

   Para configurar o Nginx para iniciar automaticamente:

		sudo systemctl enable nginx

4. Criação do Script de Monitoramento
  4.1. Script Bash para Monitoramento

   O script monitora o status do Nginx, registrando os logs em arquivos separados para os status ONLINE e OFFLINE.

   Crie o script nginx_status.sh:

		#!/bin/bash

		DATA=$(date "+%Y-%m-%d %H:%M:%S")

		if systemctl is-active --quiet nginx; then
    		   echo "$DATA Nginx ONLINE - O serviço está rodando corretamente" > /home/khauan/nginx_online.txt
		else
    		   echo "$DATA Nginx OFFLINE - O serviço não está rodando corretamente" > /home/khauan/nginx_offline.txt
		fi

  4.2. Definição de Permissões

   Dê permissões de execução ao script:

		chmod +x /home/khauan/nginx_status.sh

5. Automação com Crontab
  5.1. Configuração do Cron para Execução a Cada 5 Minutos

   Execute o comando abaixo para editar o crontab:

		crontab -e

   O sistema irá perguntar qual editor você deseja usar para editar o crontab. Escolha o editor de sua preferência (por exemplo, nano).

   Adicione a seguinte linha ao final do arquivo aberto no editor para que o script seja executado a cada 5 minutos:

		*/5 * * * * /home/khauan/nginx_status.sh

   Salve e saia do editor.

   Se você estiver usando o nano, salve com CTRL + O, pressione Enter, e depois saia com CTRL + X.
   Para outros editores, siga as instruções específicas do editor.
   Após salvar e fechar, o cron já estará configurado para rodar o script automaticamente a cada 5 minutos

   Verifique se a tarefa foi adicionada:

		sudo crontab -l

6.Testar o Script
   Execute o script manualmente para garantir que ele funcione corretamente:

		./nginx_status.sh

   Verifique se os arquivos nginx_online.txt ou nginx_offline.txt foram gerados conforme esperado no diretório /home/khauan/.

7. Verificação de logs: Para verificar se a tarefa está sendo executada conforme o esperado, você pode inspecionar os logs do cron com o seguinte comando:

		grep CRON /var/log/syslog
