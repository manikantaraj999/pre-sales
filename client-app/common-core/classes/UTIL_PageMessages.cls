/// @description Page Messages compatible with Aura or Visualforce
public with sharing class UTIL_PageMessages
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(UTIL_PageMessages.class);

    public static String SUCCESS = 'SUCCESS';
    public static String WARNING = 'WARNING';
    public static String ERROR = 'ERROR';
    public static String INFO = 'INFO';

    public static List<Message> messageList { get; private set; }

    static {
        UTIL_PageMessages.messageList = new List<Message>();
    }

    public static void addMessage(String messageType, String message)
    {
        UTIL_PageMessages.messageList.add(new Message(messageType, message));
    }

    public static void addFrameworkMessages(List<ensxsdk.EnosixFramework.Message> messages)
    {
        if (null == messages) return;

        Integer mTot = messages.size();
        for (Integer mCnt = 0 ; mCnt < mTot ; mCnt++)
        {
            ensxsdk.EnosixFramework.Message f = messages[mCnt];
            if (f.Type != ensxsdk.EnosixFramework.MessageType.INFO && 
                f.Type != ensxsdk.EnosixFramework.MessageType.SUCCESS)
            {
                UTIL_PageMessages.messageList.add(new Message(f));
            }
        }
    }

    public static void addExceptionMessage(Exception ex)
    {
        UTIL_PageMessages.messageList.add(new Message(ex));
    }

    public with sharing class Message
    {
        @AuraEnabled public String messageType { get; set; }
        @AuraEnabled public String message { get; set; }

        public Message() { }

        public Message(String messageType, String message)
        {
            this.messageType = messageType;
            this.message = message;

            logMessage();
        }

        /// @description Helper constructor to create a message from an EnosixFramework Message
        public Message(ensxsdk.EnosixFramework.Message f)
        {
            this.message = f.Text;
            this.messageType = INFO;

            switch on f.Type
            {
                when SUCCESS {
                    this.messageType = SUCCESS;
                }
                when WARNING {
                    this.messageType = WARNING;
                }
                when ERROR
                , ABNORMALEND
                , SAPEXIT {
                    this.messageType = ERROR;
                }
                when else
                {
                   this.messageType = INFO; 
                }
            }
            
            logMessage();
        }

        /// @description Helper constructor to create a message from an Exception
        public Message(Exception ex)
        {
            this.message = ex.getMessage();
            this.messageType = ERROR;

            logMessage(ex);
        }

        private void logMessage()
        {
            logMessage(null);
        }

        private void logMessage(Exception ex)
        {
            if (null != ex)
                logger.error(UTIL_PageMessages.Message.class, ex);
            else if (ERROR == this.messageType)
                logger.error(this.message, this);
            else if (WARNING == this.messageType)
                logger.warn(this.message, this);
            else
                logger.info(this.message, this);
        }
    }
}