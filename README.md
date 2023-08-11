# digio_onefinger
Um exemplo de aplicativo para processo da Digio
<div>
 <img width="200" alt="image" src="https://github.com/leocompiler/digio_onefinger/assets/807937/bad6f6fa-d4e3-4409-90b0-71ecf6e7924e">
 <img width="200" alt="image" src="https://github.com/leocompiler/digio_onefinger/assets/807937/04c45446-f355-49ea-a679-fb1d08407188">
 <img width="200" alt="image" src="https://github.com/leocompiler/digio_onefinger/assets/807937/12541ced-1043-4970-97d9-debf3f7f3f2b">
</div>
<div>
 <img width="302" alt="image" src="https://github.com/leocompiler/digio_onefinger/assets/807937/2cabf6b5-9e15-4acf-8357-26b3edbcf123">
</div>
<div>
 <img width="350" alt="image" src="https://github.com/leocompiler/digio_onefinger/assets/807937/dbaa6abe-4f52-46fd-aea7-b99e31aa991d"> 
</div>

# Arquitetura
 - MVVM + Coordinator -> padrão de projeto adotado para melhor aproveitamento dos recursos e trabalho em grupo.
 - Repository -> Acesso organizado a API com possibilidade de Mock via JSON cadastrado na pasta mock
 - Mock -> registro das respostas dos servições possibilitando desenvolvimento em modo offline ao serviço.
 - UIComponents -> reaproveitamento de componentes de Tela e organização dos recursos que são compartilhados em fluxo diferente mas mesmo componente.
 - Localizable -> Arquivo String para organização por tags os textos em pt-Br e posteriormente a possibilidade de ligar o translator ou mesmo criar outros arquivos com outros idiomas e mesmas tags
 - ViewCode (UIKIT) -> Telas construidas em ViewCode com lib UIkit
 - XIB -> um component criado com os recursos Xib para demostrar auto contracts via inspector do Xcode.
 - ConsoleLog -> pronto para injetar via Analytic google
# Libs

```
  pod 'Alamofire', '~> 4.5' ( conectividade, controle de session e tratamento de erros que o applicativo vai precisar interceptar para um controle de sessao)
  pod 'EVReflection/MoyaRxSwift', '5.10.1' ( dependencia do Alamofire para poder criar os subscription dos repositorios entre outros)
  pod 'RxSwift', '~> 4.5' ( primordial para efetuar o padrao mvvm de forma reativa para as necessidades das ViewModel registradas na Controller)
  pod 'RxCocoa', '~> 4.0' ( dependencia para RX )
  pod 'RxBiBinding', '0.2.1' (dependencia para RX)
  pod 'Moya/RxSwift', '13.0.1' (dependencia para Conectividade/Repository)
  pod 'RxAlamofire', '4.4.1' (dependencia para Conectividade/Repository)
  pod 'TrustKit', '1.7.0'  ( o TrustKit deixe para os proximos repositorys que precisa de ssl para encriptar e descriptar o body da request http/https)
  pod 'SDWebImage', '~> 4.0' ( facilitador para carregar uma imagem apartir de uma url ) 
  pod 'SnapKit', '5.6.0' ( facilitador para autoContraints via ViewCode UlKit)

```
