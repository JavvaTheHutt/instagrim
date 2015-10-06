<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator

--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="bootstrap/css/styles.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .affix
            {
                top: 0px;
                width: 100%;
            }
        </style>
    </head>
    <body>
        
            <div id='header' class="jumbotron">
                <div class='container'>
                    <h1 id='WelcomeText'>
                        Welcome To Instagrim
                    </h1>
                        <h3 id='TaglineText'>
                            Your world of depressing quote pictures.
                        </h3>
            </div>
        </div>
        
                <nav id="navbar" class="navbar navbar-inverse" data-spy="affix" data-offset="311">
                    <div class="container-fluid">
                      <!-- Brand and toggle get grouped for better mobile display -->
                      <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                          <span class="sr-only">Toggle navigation</span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="/Instagrim/">Instagrim</a>
                      </div>

                      <!-- Collect the nav links, forms, and other content for toggling -->
                      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                          <%
                              LoggedIn lg =  (LoggedIn) session.getAttribute("LoggedIn");
                              if(lg != null)
                              {
                                  String UserName = lg.getUsername();
                                  if(lg.getlogedin())
                                  {
                              %>
                              <ul class="nav navbar-nav">
                                <li><a href="upload.jsp">Upload</a></li>
                                <li><a href="/Instagrim/Images/<%=UserName%>">Your Images</a></li>
                              </ul>
                              <ul class="nav navbar-nav navbar-right">
                                <li><a href="/Instagrim/Logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                              </ul>
                              <%}
                              }else{
                              %>
                                <ul class="nav navbar-nav navbar-right">
                                    <li><a href="register.jsp"><span class="glyphicon glyphicon-user"</span> SignUp</a></li>
                                    <li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"</span> Login</a></li>
                                </ul>
                              <%
                                  }
                              %>
                      </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-fluid -->
                  </nav>
                <div class="container-fluid">
                    <p id="text">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque id imperdiet libero, ac semper lacus. Proin vitae ante facilisis, commodo turpis in, ultricies odio. Aenean metus quam, pretium quis augue a, molestie sollicitudin neque. Quisque ac lacus vitae arcu euismod ultricies. Vivamus sed rutrum enim. Suspendisse laoreet posuere magna sit amet suscipit. Nullam eleifend feugiat tristique. Fusce placerat justo ut est mattis, eget interdum risus blandit. Pellentesque ornare vestibulum augue. Ut risus elit, accumsan a ornare sed, ullamcorper quis erat. Nulla dignissim ipsum ut elit mattis volutpat.

Donec sed enim ac velit malesuada sagittis vel a ipsum. In eget diam venenatis arcu semper elementum. Cras sed felis eget risus tincidunt laoreet. Vivamus tempus quis nunc ut porta. Pellentesque rhoncus metus sit amet purus viverra posuere. Sed suscipit elementum nisi, non dapibus dolor faucibus eu. Etiam condimentum tortor non mollis hendrerit. Cras ante nibh, bibendum a hendrerit id, posuere non nibh. Maecenas at nibh eget massa consectetur congue a gravida ipsum.

Curabitur ornare finibus libero, nec rhoncus lectus laoreet ut. Fusce ac maximus nisi. Fusce vulputate molestie magna eget semper. Phasellus interdum maximus nisi, eget varius purus. Praesent euismod lectus in quam consequat facilisis. Morbi at mauris vulputate enim semper tincidunt. Donec tortor lorem, feugiat ut quam sed, consequat efficitur massa. Pellentesque cursus arcu sed pharetra egestas. Pellentesque vel elit non massa dignissim sollicitudin placerat eu felis. Suspendisse tristique libero quis arcu cursus viverra. Nullam bibendum leo pharetra, condimentum nunc vel, laoreet lorem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Quisque auctor placerat ipsum, sit amet interdum odio ultrices vitae. Donec vel blandit arcu. Aenean venenatis dui sit amet volutpat hendrerit. Nullam nulla nisi, mollis quis condimentum id, lacinia pretium justo.

Proin a rutrum nisi. Curabitur sit amet placerat leo. Sed ultrices leo nulla. Curabitur sollicitudin tortor sit amet vulputate consequat. In ac mattis enim, dapibus sollicitudin risus. Donec sagittis a arcu efficitur consectetur. Vestibulum bibendum nisi ut sollicitudin mattis. Mauris eu auctor justo. Etiam mi sapien, auctor ut fermentum id, pharetra finibus quam.

Praesent quis turpis maximus, posuere ligula eget, molestie tellus. Mauris elementum finibus laoreet. Integer ullamcorper quis libero nec hendrerit. Vivamus consectetur lacus ut porttitor mollis. Sed mi sem, faucibus vel malesuada sit amet, eleifend id ante. Nunc vehicula congue neque, ut interdum lorem aliquam eget. Proin quis tellus iaculis, aliquet orci in, interdum nulla. Duis tincidunt diam non ipsum rutrum, vel maximus arcu imperdiet. Vestibulum id erat accumsan, molestie tortor a, ornare neque. Proin id metus nec augue efficitur tincidunt ac accumsan erat. Vestibulum magna magna, imperdiet eu purus ut, tincidunt pulvinar magna. Curabitur vulputate dictum ullamcorper. Maecenas quis facilisis nibh. Etiam ultricies sapien at diam posuere, quis tincidunt dui vehicula.

Etiam cursus, magna nec tempor interdum, nisl risus hendrerit turpis, a vehicula arcu nibh ac tortor. Etiam consectetur eros a est feugiat, sit amet placerat nunc tristique. Donec porta massa vel nunc fermentum varius. Sed augue nunc, maximus in leo eget, scelerisque rutrum sem. Vestibulum egestas arcu sem, vel tristique diam aliquam eu. Sed varius scelerisque magna, at varius metus finibus gravida. Integer turpis sapien, auctor in tellus id, laoreet congue augue.

Nullam sed blandit diam, id vestibulum mi. Aenean lobortis est dolor, id bibendum purus consectetur cursus. Donec ullamcorper quam nec sagittis molestie. Proin vestibulum fringilla ante, id imperdiet neque pulvinar in. Quisque eu feugiat erat, nec pellentesque magna. Fusce hendrerit lacus vel neque condimentum scelerisque. Integer in metus ac urna vehicula commodo. Suspendisse tincidunt, massa ac fringilla maximus, sem urna congue velit, nec faucibus nisi mi at urna. Sed at blandit sapien. Ut aliquet nibh ut neque hendrerit vulputate. Nulla facilisi. Vivamus lobortis, elit non placerat tempus, purus lectus mattis ligula, eget ultrices justo leo eget turpis. Fusce dui justo, fringilla nec enim non, pulvinar mollis erat. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla nec dolor quis nunc volutpat eleifend.

Sed at ultrices nunc. Mauris venenatis nibh eu enim dignissim semper. Aliquam erat volutpat. Suspendisse tincidunt lectus nulla, sit amet dapibus augue tristique eget. Fusce commodo lacus sed magna ultrices tempus. Mauris sed ante odio. Cras quis quam bibendum, ornare nisl ut, tristique enim. Nam urna libero, efficitur nec eleifend quis, condimentum non risus.

Duis tristique sed arcu in auctor. Cras egestas risus nibh, vitae mattis dui tempus sed. Morbi non laoreet augue, id semper quam. Mauris eget mattis mauris. Praesent quis fermentum arcu. Sed dui lectus, luctus eu blandit in, auctor a ipsum. Curabitur nibh leo, volutpat vel euismod vel, elementum vestibulum diam. Donec vitae ligula non lacus volutpat consectetur sit amet imperdiet augue. Ut luctus pharetra massa, vitae semper sem ultrices non. Aliquam erat volutpat. Mauris sollicitudin augue ultrices sem egestas commodo. Donec eget sodales magna. Pellentesque convallis convallis lectus, quis ullamcorper mi dignissim id. Nunc varius mi ut augue bibendum, vitae porttitor nulla malesuada.

Maecenas maximus, tellus id porta malesuada, nulla eros feugiat nisi, sit amet eleifend ex turpis sed quam. Duis sagittis elit vel nisi viverra rutrum ac a ex. Morbi ut congue lectus. Nullam interdum ac ex vel dictum. Aenean libero nisl, consectetur lobortis euismod a, elementum sed turpis. Sed dictum eleifend lacus quis suscipit. Duis diam neque, ullamcorper eget fermentum nec, dictum hendrerit tellus. Phasellus pharetra elit vel consectetur sollicitudin. Maecenas in tempus dolor. Sed nec iaculis purus. In viverra ac massa ut suscipit.

Vivamus lacinia massa et ante iaculis, sit amet venenatis enim mattis. Curabitur condimentum velit quis ante sollicitudin rhoncus. In hac habitasse platea dictumst. Praesent placerat pulvinar laoreet. Curabitur consectetur efficitur sem porttitor aliquam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent purus felis, euismod vitae pretium eu, viverra eget mauris. Suspendisse enim urna, tincidunt sed venenatis eget, scelerisque non sem. Vivamus purus magna, egestas vel euismod eget, vulputate non metus. Morbi non ex orci. Aenean vitae volutpat risus, non molestie eros.

Proin molestie suscipit feugiat. Phasellus et feugiat tellus, in vehicula nisl. Pellentesque tempor, lorem nec congue venenatis, magna magna facilisis mauris, in malesuada nibh nisi eget dolor. Curabitur quis purus leo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer vitae dolor elementum, vehicula leo eget, scelerisque lacus. Sed lorem mauris, ornare non massa at, pharetra suscipit odio.

Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque mollis metus vitae scelerisque pellentesque. Maecenas in egestas neque, nec porttitor arcu. Phasellus sed tristique metus, in luctus augue. Vestibulum nec mauris ut orci volutpat ullamcorper. Cras vel tellus orci. Aliquam id efficitur tortor. Ut a sapien tempus, scelerisque ligula vel, efficitur nisl. Nulla porta tellus eu feugiat imperdiet. Curabitur pellentesque odio sed nibh lacinia, sed tempor nisi imperdiet. Aenean vulputate libero vitae sapien scelerisque, non varius dolor feugiat. Maecenas blandit mi eu sapien facilisis pretium. Maecenas in aliquam mi, vel venenatis est. Aliquam erat volutpat. Proin sit amet odio eget nisl cursus sollicitudin a gravida est.

In non magna sed nibh accumsan dictum sit amet in eros. Duis nec accumsan ipsum. Aliquam sit amet dui non sapien lobortis malesuada. Vestibulum diam risus, dapibus in diam at, venenatis tempus tellus. Fusce vitae lorem pharetra, suscipit risus quis, ultrices neque. Pellentesque dignissim, nulla sed volutpat varius, orci justo imperdiet mauris, a aliquet lorem nisi ut dolor. Proin imperdiet tincidunt ipsum, pharetra dapibus nunc porttitor non. Etiam in eros et odio laoreet efficitur. Proin congue aliquam eros. Etiam et cursus nisl. Vestibulum eu mauris quis quam porta viverra.

Nulla commodo elit vitae vestibulum dictum. In in consequat velit. Donec semper enim porttitor ligula pulvinar feugiat. Donec ac nunc dapibus justo dictum gravida. Cras pulvinar aliquam ex. Aenean ac risus facilisis nulla tincidunt tincidunt non non metus. Ut sagittis rutrum auctor.

Morbi eu viverra purus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus commodo, massa non viverra tincidunt, lorem justo facilisis diam, vel aliquet elit justo tristique turpis. Donec arcu enim, ornare id feugiat vitae, sagittis vitae felis. Sed lacinia erat nulla, ac maximus turpis faucibus eu. Nulla maximus sed lectus eget elementum. Pellentesque dictum, magna non vehicula tempus, leo nibh bibendum nisl, in tempor tellus mi ac dolor. Aliquam accumsan elementum est quis aliquet. Quisque convallis ac sapien at tempor. Suspendisse potenti. Aenean faucibus erat id dictum molestie.

Vivamus et sapien interdum, varius justo id, dictum quam. In tempor placerat justo, eget semper diam iaculis elementum. Curabitur dictum nisl at lacus dictum, non sagittis odio fringilla. Sed sodales sit amet ante vitae consequat. Nam euismod efficitur metus ac mattis. Proin massa turpis, euismod non sodales et, mattis nec neque. Vivamus eu dignissim turpis, id efficitur ex. Ut felis purus, porta et cursus mattis, malesuada vitae felis. Etiam bibendum mauris nec est convallis volutpat vel ac tortor. Aenean ullamcorper mollis ultricies.

Maecenas sed velit ac erat blandit consectetur. Fusce euismod, urna feugiat faucibus sagittis, enim ex pellentesque urna, eget sodales erat eros eget urna. Mauris vehicula mauris mi, ac ornare felis accumsan suscipit. Proin ut sapien velit. Curabitur ut condimentum ipsum. Aenean ac imperdiet purus. Mauris quis nunc sed massa mattis bibendum. Vestibulum sit amet ipsum non mauris sollicitudin sagittis. Nam purus ipsum, venenatis rutrum dignissim a, porttitor a magna. Praesent massa elit, efficitur quis orci non, condimentum tristique nisi. Phasellus bibendum mauris ligula, ut hendrerit nisl ornare accumsan. Cras sit amet tellus elit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec non interdum orci, et lobortis nisi.

Fusce ex massa, eleifend eget neque a, pellentesque scelerisque enim. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin sagittis est quis libero accumsan tempor. Nam sagittis dolor non venenatis rhoncus. Aenean in ullamcorper sem, non scelerisque erat. Vestibulum velit libero, rutrum non libero in, vulputate faucibus purus. Nam mi lectus, fermentum a pellentesque a, rhoncus ac libero. Integer eu vulputate sem, quis rhoncus libero. Praesent imperdiet diam ac purus sodales vulputate. Phasellus feugiat dui a tristique rhoncus. Curabitur non libero sed odio tincidunt varius congue sed mauris. Nulla facilisi. Integer sit amet accumsan velit. Vivamus luctus tortor arcu, non porttitor nisl porttitor at.

Integer vitae rhoncus metus, ac porta leo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent id efficitur lorem, laoreet condimentum elit. Fusce tincidunt lacus vitae consectetur blandit. Maecenas gravida arcu at mauris mollis, in maximus nulla dictum. Cras eu accumsan risus, vel hendrerit velit. Nunc mattis, erat at imperdiet condimentum, sapien purus tincidunt mi, quis varius enim justo at ipsum. Suspendisse pulvinar urna ex, sit amet feugiat dui rhoncus id. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vitae tellus hendrerit, ullamcorper metus a, vestibulum risus.

Donec et massa est. Praesent sit amet scelerisque massa, sed pellentesque nunc. Sed sodales, velit quis semper bibendum, purus metus pharetra felis, lobortis fringilla ligula purus eu dolor. Curabitur vitae mauris ac mauris laoreet sollicitudin. Proin sed auctor ex. Aenean tincidunt tellus id mi mattis mollis. In convallis fringilla justo non iaculis. Mauris fringilla neque a velit dignissim, vitae pharetra justo fringilla. Aliquam in ex eleifend, varius eros eu, posuere ex. Pellentesque venenatis scelerisque libero, id tristique mi semper eu. Pellentesque elementum arcu purus, vel iaculis enim mattis et.

Nam faucibus ex sed arcu fringilla malesuada. Fusce convallis massa id leo tincidunt, et lobortis nunc finibus. Quisque eget tortor est. Mauris pretium ex et nibh lacinia convallis. Aenean turpis neque, porta et orci id, ultricies ornare lorem. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus commodo ultrices tellus, quis dapibus sapien fermentum dapibus. Phasellus vehicula odio at nisi ultricies, a rutrum est placerat. Vivamus sed turpis a turpis vestibulum venenatis vel vel purus.

Maecenas turpis mauris, cursus sed ipsum eget, tristique ullamcorper neque. Quisque augue nisi, eleifend at enim a, consequat malesuada velit. Maecenas auctor massa eu placerat luctus. Quisque facilisis nisl in lectus mattis, at cursus diam posuere. Nullam ornare ante tellus, sit amet pulvinar dui interdum vitae. Aenean quis vehicula nibh, a commodo leo. In vitae tortor feugiat, mollis eros nec, venenatis justo. Donec lobortis orci ipsum, id pellentesque magna vulputate ac. Nulla sodales condimentum lectus eget luctus. Duis sed justo nec dolor pretium imperdiet sed a magna. Donec et urna non metus dapibus ullamcorper ut nec felis. Cras congue nec ex nec condimentum.

Nunc at posuere mauris. Vestibulum vel varius urna, et dapibus augue. Donec consequat tortor ac nulla porttitor pretium. Sed gravida nisi non lorem feugiat, vel ultricies enim laoreet. Nullam sed imperdiet nibh. Nullam fermentum aliquam scelerisque. Donec consectetur nibh sit amet justo aliquam, id consequat dolor vulputate. Suspendisse potenti. Suspendisse vitae ex faucibus, mollis turpis finibus, tristique dui.

Etiam ut eros quis elit tempor faucibus ut ut eros. Nam et nisi mauris. Sed euismod et nibh sed dictum. Mauris ut bibendum risus, nec feugiat massa. Pellentesque in enim lacinia, vehicula mauris id, blandit neque. Donec finibus sapien ac malesuada ullamcorper. Phasellus at dignissim mi. Aenean aliquam non neque vitae mollis. Quisque libero elit, rhoncus ac semper ut, finibus vitae dui. Curabitur sollicitudin, mi vel pellentesque dapibus, magna nulla aliquam risus, ut sodales purus ex sed mi. Etiam accumsan quis dui at vehicula. Cras suscipit magna nec sem finibus, et gravida nibh malesuada. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Proin consequat pharetra mauris, at sagittis elit mollis vel. Phasellus odio velit, pellentesque a mollis quis, mollis malesuada est. Nunc vitae tempor neque, fermentum lacinia risus.

Pellentesque eget lectus nunc. Donec dignissim purus ut arcu aliquam, dignissim commodo nunc aliquam. Praesent at tellus non metus convallis placerat. Ut aliquet, est non egestas ultrices, metus justo lacinia orci, quis pharetra metus odio a nibh. Praesent mollis sapien id massa tincidunt, in euismod justo volutpat. Suspendisse luctus, ligula ut rhoncus facilisis, augue nunc egestas sem, nec rutrum turpis leo a ex. Nullam eu mauris et ipsum feugiat scelerisque quis at metus. Sed pulvinar eu elit in luctus. Suspendisse consectetur efficitur nisi vitae condimentum. Vestibulum erat felis, tempus ut nunc et, vestibulum rutrum justo. Ut pretium nulla nisl, in rhoncus elit eleifend at. Nam non diam quis sem tristique mollis quis ac erat. Praesent mollis, augue a finibus faucibus, mi mi accumsan sapien, sed vehicula neque enim quis nisi. Aenean posuere lacus vel neque tincidunt luctus. Proin suscipit orci ac augue feugiat tincidunt. Sed viverra sit amet est eget laoreet.

Maecenas erat turpis, pellentesque et ipsum ut, accumsan volutpat lorem. Suspendisse euismod a dolor vel egestas. Curabitur egestas in orci et hendrerit. Vestibulum nisi purus, dictum sed ipsum quis, semper congue lectus. Donec ut nisl nec nibh varius convallis. Donec consectetur justo vitae dui maximus, in sagittis lectus placerat. Proin ante tellus, lobortis nec mattis et, porta sit amet libero. Fusce tincidunt lacus purus, vitae semper neque aliquam vel. Praesent aliquet quis justo id auctor. Quisque dolor felis, interdum sit amet nibh vitae, pharetra cursus tortor. Fusce dolor neque, suscipit et orci eu, porta faucibus mi. Donec laoreet nunc vulputate velit molestie pellentesque. Maecenas vel enim a elit cursus posuere ac in quam. Curabitur facilisis neque tellus, vitae vestibulum lacus sollicitudin in. Vivamus placerat bibendum purus eu consectetur. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.

Phasellus ac laoreet nisi. Suspendisse potenti. Sed molestie, ante et fringilla consequat, dolor urna tincidunt enim, et fermentum quam urna blandit mi. Vestibulum finibus, sapien volutpat accumsan rhoncus, libero diam elementum lacus, egestas blandit magna dolor at ante. Fusce fermentum consectetur dictum. Vivamus eu blandit urna. Aliquam nulla elit, hendrerit vel tortor sed, fermentum fermentum magna. In placerat eros ut magna sollicitudin, ac dignissim enim luctus. Sed scelerisque et leo ac malesuada. Ut a sapien non nisi mattis volutpat. Integer eu magna nibh. Ut laoreet eros egestas molestie ultricies. Nunc tristique bibendum libero, in eleifend lectus suscipit sed.

Vestibulum nibh augue, blandit sit amet orci aliquam, dictum iaculis nisi. Quisque id enim et risus fermentum rhoncus. Sed eu ultrices metus, ac dapibus nulla. Mauris elementum justo nec finibus molestie. Quisque aliquam est eget eros placerat, ac finibus lacus semper. Donec ornare augue in metus facilisis rutrum et vitae lectus. Praesent sit amet lobortis leo, sed sodales arcu. Mauris sed metus fringilla metus dapibus hendrerit id in arcu. Pellentesque molestie sollicitudin leo, id auctor tortor fringilla a. Vivamus tincidunt porttitor magna, at ornare nunc tempor a.

Quisque consectetur tempor nisl sit amet feugiat. Donec pulvinar elit felis, quis faucibus neque vehicula eu. Curabitur vitae velit id nibh porttitor fermentum accumsan id erat. Duis semper laoreet mi blandit aliquet. Suspendisse laoreet sem ut neque tincidunt egestas. Praesent eget porttitor nunc. Praesent et eros id est interdum vulputate. Nam rutrum sagittis augue, at fringilla elit tempor in. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum quis dolor non suscipit. Praesent in ante sit amet ante vestibulum blandit sed eget quam. Maecenas interdum pharetra tincidunt. Praesent mauris metus, condimentum non nisi vitae, vehicula maximus arcu. Curabitur tincidunt tortor nec dolor viverra sagittis. Vivamus velit erat, auctor ac leo in, mollis congue felis. Donec quis tempus tortor, at suscipit odio.
                    </p>
                </div>
            <div class="navbar navbar-default navbar-fixed-bottom" >
                <ul>
                    <li>&COPY; Andy C</li>
                </ul>
            </div>
    </body>
</html>
