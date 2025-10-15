import axios from "axios";

export class MessageGatewayService {
  protected MESSAGE_GATEWAY_URL = process.env.MESSAGE_GATEWAY_URL;
  private client = axios.create({
    baseURL: this.MESSAGE_GATEWAY_URL,
  });

  public async publishMessage(
    body: {
      template: string;
      module: string;
      targets: {
        [channel in Channel]?: string[];
      };
      data: { [key: string]: string | number | object[] };
    },
    topic: string = "Notifications"
  ) {
    try {
      console.log("publishMessage", body);
      const response = await this.client.post(
        `/v2/publish/${process.env.MESSAGE_TOPIC_PREFIX}_${topic}`,
        body
      );
      return response.data;
    } catch (error) {
      console.error("[Error#publishMessage]", error);
      throw error;
    }
  }
}

export enum Channel {
  emails = "emails",
  lines = "lines",
  mobiles = "mobiles",
}
