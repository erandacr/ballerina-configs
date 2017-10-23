import ballerina.net.jms;
import ballerina.lang.system;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:"queue",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    connectionUsername:"user",
    connectionPassword:"password"
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
        jms:ClientConnector jmsEP;
        map properties = {"initialContextFactory":"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
                             "providerUrl":"tcp://localhost:61616",
                             "connectionFactoryName":"QueueConnectionFactory",
                             "connectionFactoryType":"queue",
                             "connectionUsername":"user",
                             "connectionPassword":"password"
                         };

        system:println(request.getTextMessageContent());

        jmsEP = create jms:ClientConnector(properties);
        jms:JMSMessage message2 = jms:createTextMessage(jmsEP);
        message2.setTextMessageContent("{\"WSO2\":\"Ballerina\"}");
        jmsEP.send("MyQueue2", message2);
    }
}
