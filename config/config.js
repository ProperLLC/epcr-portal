/**
 * Created by terry on 1/15/14.
 */
angular.module("services.envConfig", [])
    .constant("config",
        {
            api :
                {
                    host : '@@api.host',
                    protocol : '@@api.protocol',
                    port : '@@api.port'
                }
        }
    )
