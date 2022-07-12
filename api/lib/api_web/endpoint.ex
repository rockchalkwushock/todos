defmodule AppWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :api

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_api_key",
    signing_salt: "nozDA/Zw"
  ]

  # socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug(Phoenix.CodeReloader)
    plug(Phoenix.Ecto.CheckRepoStatus, otp_app: :api)
  end

  plug(Plug.RequestId)
  plug(Plug.Telemetry, event_prefix: [:phoenix, :endpoint])

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)
  plug(Plug.Session, @session_options)

  # https://hexdocs.pm/corsica/Corsica.html#content
  plug(Corsica,
    allow_credentials: true,
    # TODO:
    # Harden this before releasing the API.
    allow_headers: :all,
    # TODO:
    # Check that "HEAD" & "OPTIONS" even need to be provided.
    allow_methods: ["GET", "HEAD", "OPTIONS", "POST"],
    # FIXME:
    # Remove before releasing the API.
    log: [accepted: :debug, invalid: :debug, rejected: :warn],
    max_age: 86400,
    # FIXME:
    # Is there a more conditional manner in doing this?
    # Obviously don't want localhost:3000 in production...
    origins: [~r{https:\/\/(solitary-pine-572)(-web-|-.+-)(rockchalkwushock.vercel.app)}, "http://localhost:3000"]
  )

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug(Plug.Static,
    at: "/",
    from: :api,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)
  )

  plug(AppWeb.Router)
end
