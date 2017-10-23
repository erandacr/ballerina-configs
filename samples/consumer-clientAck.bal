import ballerina.net.jms;
import ballerina.lang.system;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:"queue",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    acknowledgementMode:jms:CLIENT_ACKNOWLEDGE
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
        system:println(request.getTextMessageContent());
        system:println("Acking the request");
        // pass jms:DELIVERY_ERROR
        request.acknowledge(jms:DELIVERY_SUCCESS);
    }
}

