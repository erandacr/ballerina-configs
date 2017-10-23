import ballerina.net.jms;
import ballerina.lang.system;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    concurrentConsumers:"15",
    connectionFactoryType:jms:TYPE_QUEUE
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage request) {
	    system:println(request.getTextMessageContent());
    }
}
