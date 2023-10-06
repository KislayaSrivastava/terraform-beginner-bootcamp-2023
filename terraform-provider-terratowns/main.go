package main

import (
	//"log"
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

func main(){
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	fmt.Println("Hello World Kislaya")
}

// in Golang, a titlecase function will get exported
func Provider() *schema.Provider{
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{

		},
		DataSourcesMap: map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Schema{
			"endpoint":{
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token":{
				Type: schema.TypeString,
				Sensitive: true, //make the token as sensitive in logs hiding
				Required: true,
				Description: "Bearer token for Authorization",
			},
			"user_uuid":{
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for Configuration",
				//ValidateFunc: validateUUID,
			},
		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
}

//This is function to validate the UUID 
// func validateUUID(v interface{}, k string) (ws []string, errors []error){
// 	log.Print('validateUUID:start')
// 	value := v.(string)
// 	if _,err = uuid.Parse(value); err != nil {
// 		errors = append(error,fmt.Errorf("Invalid UUID format"))
// 	}
// 	log.Print('validateUUID:end')
// }