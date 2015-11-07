source $stdenv.setup

mkdir -p $out
cp -R bin config lib $out

# don't want to have binary with name plugin
mv $out/bin/plugin $out/bin/elasticsearch-plugin

# set ES_CLASSPATH and JAVA_HOME
wrapProgram $out/bin/elasticsearch                            \
  --prefix ES_CLASSPATH : "$out/lib/${name}.jar":"$out/lib/*" \
  ${if (!stdenv.isDarwin)
    then ''--prefix PATH : "${utillinux}/bin/"''
    else ''--prefix PATH : "${getopt}/bin"''}                 \
  --set JAVA_HOME "${jre}"                                    \
                                                              \
  # TODO: Check in future versions if it can be removed.      \
  # Disable security, since otherwise es is not starting.     \
  --set ES_JAVA_OPTS "-Des.security.manager.enabled=false"

wrapProgram $out/bin/elasticsearch-plugin \
  --prefix ES_CLASSPATH : "$out/lib/${name}.jar":"$out/lib/*":"$out/lib/sigar/*" \
  --set JAVA_HOME "${jre}"