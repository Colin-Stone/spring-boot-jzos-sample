export JAVA_HOME=/usr/lpp/java/J8.0_64
if [[ ":$PATH:" == *":$JAVA_HOME/bin:"* ]]; then
  echo "ZOWE_JAVA_HOME already exists on the PATH"
else
  echo "Appending ZOWE_JAVA_HOME/bin to the PATH..."
  export PATH=$PATH:$JAVA_HOME/bin
  echo "Done."
fi

echo JAVA_HOME=$JAVA_HOME

DIR=`dirname $0`
	
java -cp .:$JAVA_HOME/lib/ext/ibmjzos.jar \
	-Dserver.ssl.key-password=zoe_password \
 	-Dserver.ssl.key-store=$DIR/../../0.9.3/api-mediation/keystore/api_gateway.ks \
	-Dserver.ssl.key-store-type=JKS -Dserver.ssl.key-store.password=zoe_password \
	-Dserver.port=2956 -Dserver.ssl.enabled=true -Dserver.scheme=https \
	-Dserver.serviceId=jzos -Dserver.serviceTitle="z/OS System Information" -Dserver.serviceDescription="Collecting z/OS System Information based on JZOS" \
	-jar jzos.jar com.zowe.jzos.JzosApplication

	java -cp .:$JAVA_HOME/lib/ext/ibmjzos.jar -Xms16m -Xmx512m \
    -Dserver.port={nnnn} \
    -Dserver.sslEnabled=true -Dserver.scheme=https \
    -Dserver.ssl.keyAlias=localhost \
    -Dserver.ssl.keyStore={your root}}/zowe/1.0.0/api-mediation/keystore/localhost/localhost.keystore.p12 \
    -Dserver.ssl.keyStorePassword=password \
    -Dserver.ssl.keyStoreType=PKCS12 \
	-Dserver.serviceId=jzos -Dserver.serviceTitle="z/OS Java Information" -Dserver.serviceDescription="API's for collecting z/OS System Information" \
    -jar jzos-0.0.1-SNAPSHOT.jar com.zowe.jzos.JzosApplication