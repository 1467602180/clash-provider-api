package main

import (
	"github.com/labstack/echo/v5"
	"github.com/pocketbase/pocketbase/core"
	"log"
	"net/http"

	"github.com/pocketbase/pocketbase"
)

func main() {
	app := pocketbase.New()

	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		_, err := e.Router.AddRoute(echo.Route{
			Method: http.MethodGet,
			Path:   "/api/configs/getConfig",
			Handler: func(c echo.Context) error {
				token := c.QueryParam("token")
				collection, _ := app.Dao().FindCollectionByNameOrId("configs")
				result, err := app.Dao().FindFirstRecordByData(collection, "token", token)
				if err != nil {
					return err
				}
				if token == "" {
					return nil
				}
				return c.String(200, result.GetStringDataValue("config"))
			},
			Middlewares: []echo.MiddlewareFunc{},
		})
		if err != nil {
			return err
		}

		return nil
	})

	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		_, err := e.Router.AddRoute(echo.Route{
			Method: http.MethodGet,
			Path:   "/api/proxys/getConfig",
			Handler: func(c echo.Context) error {
				token := c.QueryParam("token")
				collection, _ := app.Dao().FindCollectionByNameOrId("proxys")
				result, err := app.Dao().FindFirstRecordByData(collection, "token", token)
				if err != nil {
					return err
				}
				if token == "" {
					return nil
				}
				return c.String(200, result.GetStringDataValue("proxy"))
			},
			Middlewares: []echo.MiddlewareFunc{},
		})
		if err != nil {
			return err
		}

		return nil
	})

	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
