import express from 'express';
import path from 'path';
import livereload from 'livereload';
import connectLivereload from 'connect-livereload';
import {
  MessageGatewayService,
  Channel,
} from './message_gateway/MessageGatewayService';

const app = express();
const port = 3030;

// สร้าง livereload server และกำหนดให้เฝ้าดูโฟลเดอร์ views
const liveReloadServer = livereload.createServer();
liveReloadServer.watch(path.join(__dirname, 'views'));

// เมื่อ livereload server เริ่มเชื่อมต่อ ให้รีเฟรชเบราว์เซอร์
liveReloadServer.server.once('connection', () => {
  setTimeout(() => {
    liveReloadServer.refresh('/');
  }, 100);
});

app.use(connectLivereload());

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.get('/', (req, res) => {
  res.render('index', {
    logo: 'https://space.nipa.cloud/assets/images/Logo-space.png',
    recipient_name: 'John Doe',
    billing_period: '01/JAN/25 - 01/FEB/25',
    project_id: 'IDW985W6-3W73-11WW-WW56-0242WW120002',
    resources: [
      { name: 'Compute Instance', price: '100,000.00 THB' },
      { name: 'Volumes', price: '50,000.00 THB' },
    ],
    total_price: '225,000.00 THB',
    vat: '15,750.00 THB',
    grand_total: '240,750.00 THB',
    // customer_support_phone: "08 6328 3030",
    // support_email: "support@nipa.cloud",
  });
});

const messageGatewayService = new MessageGatewayService();

app.get('/send', async (req, res) => {
  try {
    const body = {
      template: 'POSTPAID_CYCLE_REPORT',
      module: '(dev) Nipa Cloud Space',
      targets: {
        [Channel.emails]: ['chonchanok@nipa.cloud'],
      },
      data: {
        logo: 'https://space.nipa.cloud/assets/images/Logo-space.png',
        recipient_name: 'John Doe',
        billing_period: '01/JAN/25 - 01/FEB/25',
        project_id: 'IDW985W6-3W73-11WW-WW56-0242WW120002',
        resources: [
          { name: 'Compute Instance', price: '100,000.00 THB' },
          { name: 'Volumes', price: '50,000.00 THB' },
        ],
        total_price: '225,000.00 THB',
        vat: '15,750.00 THB',
        grand_total: '240,750.00 THB',
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
