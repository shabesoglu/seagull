defmodule Event.TextBox do

   @events [
      update: :command_text_updated,
      enter_pressed: :command_text_enter,
    ]

  def get_events() do
    @events
  end

  lc {sg, wx} inlist @events do
    def react(data, unquote(sg)) do
      :wxEvtHandler.connect Keyword.get(data, :wxobject), unquote(wx), [userData: {:text_box, Keyword.get(data, :id)}]
      true
    end
  end

  def react(_data, _event), do: false

  lc {sg, wx} inlist @events do
    def translate(_wxid, _wxobject, id, {_, unquote(wx), value, _, _}, window) do
      widget=Keyword.get window, id
      pid=Keyword.get widget, :pid
      pid<-[self, id, unquote(sg), list_to_binary(value)]
      true
    end
  end
  def translate(_wx_id, _object, _id, _event, _window) do
    false
  end

end
