import express from "express";
import path from "path";
import livereload from "livereload";
import connectLivereload from "connect-livereload";
import {
  MessageGatewayService,
  Channel,
} from "./message_gateway/MessageGatewayService";

const app = express();
const port = 3030;

// สร้าง livereload server และกำหนดให้เฝ้าดูโฟลเดอร์ views
const liveReloadServer = livereload.createServer();
liveReloadServer.watch(path.join(__dirname, "views"));

// เมื่อ livereload server เริ่มเชื่อมต่อ ให้รีเฟรชเบราว์เซอร์
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
    logo: "https://space.nipa.cloud/assets/images/Logo-space.png",
    recipient_name: "John Doe",
    wallet_type: "POSTPAID",
    cycle_started_at: "01 JAN 25",
    cycle_end_at: "31 FEB 25",
    project_id: "ioW985W6-3W73-11WW-WW56-0242WW120002",
    project_name: "test_project",
    total_price: 2251234567,
    vat: 2000467,
    grand_total: 245467,
    outstanding_balance: 34674670,
    resources: [
      { name: "Compute Instance", price: 146787897746700 },
      { name: "Volumes", price: 54674670 },
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
        [Channel.emails]: ["chonchanok@nipa.cloud, c.wongaphai@gmail.com"],
      },
      data: {
        subject: `Cycle Report - 01 JAN 25 - 31 FEB 25`,
        logo: "https://space.nipa.cloud/assets/images/Logo-space.png",
        recipient_name: "John Doe",
        wallet_type: "POSTPAID",
        cycle_started_at: "01 JAN 25",
        cycle_end_at: "31 FEB 25",
        project_id: "IDW985W6-3W73-11WW-WW56-0242WW120002",
        project_name: "test_project",
        total_price: 2251234567,
        vat: 2000000,
        grand_total: 245000,
        outstanding_balance: 30000000,
        resources: [
          { name: "Compute Instance", price: 100000000 },
          { name: "Volumes", price: 50000000 },
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
