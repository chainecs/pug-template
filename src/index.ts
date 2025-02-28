import express from "express";
import path from "path";
import livereload from "livereload";
import connectLivereload from "connect-livereload";
import {
  MessageGatewayService,
  Channel,
} from "./message_gateway/MessageGatewayService";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();

const app = express();
const port = process.env.PORT;

app.use(cors());

const liveReloadServer = livereload.createServer();
liveReloadServer.watch(path.join(__dirname, "views"));

liveReloadServer.server.once("connection", () => {
  setTimeout(() => {
    liveReloadServer.refresh("/");
  }, 100);
});

app.use(connectLivereload());

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "pug");

app.get("/", (req, res) => {
  res.render("index", {
    logo: `${process.env.LOGO_URL}`,
    recipient_name: "John Doe",
    wallet_type: "POSTPAID",
    cycle_started_at: "01 JAN 25",
    cycle_end_at: "31 FEB 25",
    project_id: "ioW985W6-3W73-11WW-WW56-0242WW120002",
    project_name: "test_project",
    outstanding_amount: 34674670,
    total_amount: 2251234567,
    vat_amount: 2000467,
    grand_total: 1000001,
    resources: [
      { name: "Compute Instance", price: 146787897746700 },
      { name: "Volumes", price: 54674670 },
      { name: "External IPs", price: 0 },
    ],
  });
});

const messageGatewayService = new MessageGatewayService();

app.get("/send", async (req, res) => {
  try {
    const body = {
      template: "WALLET_CYCLE_USAGE_REPORT",
      module: "(dev) Nipa Cloud Space",
      targets: {
        [Channel.emails]: [
          "chonchanok@nipa.cloud, c.wongaphai@gmail.com, 6570049021@student.chula.ac.th",
        ],
      },
      data: {
        subject: `Cycle Report - 01 JAN 25 - 31 FEB 25`,
        logo: `${process.env.LOGO_URL}`,
        recipient_name: "John Doe",
        wallet_type: "POSTPAID",
        cycle_started_at: "01 JAN 25",
        cycle_end_at: "31 FEB 25",
        project_id: "IDW985W6-3W73-11WW-WW56-0242WW120002",
        project_name: "test_project",
        total_amount: 2251234567,
        vat_amount: 2000000,
        grand_total: 1000001,
        outstanding_amount: 30000000,
        resources: [
          { name: "Compute Instance", price: 100000000 },
          { name: "Volumes", price: 50000000 },
          { name: "External IPs", price: 0 },
        ],
      },
    };
    const response = await messageGatewayService.publishMessage(body);
    res.json(response);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
