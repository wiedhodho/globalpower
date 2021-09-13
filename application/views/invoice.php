<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>INVOICE</title>

  <style type="text/css">
    @page {
      margin: 30px;
      size: A4;
    }

    * {
      font-family: Verdana, Arial, sans-serif;
    }

    p,
    table {
      font-size: 8pt;
    }

    table.isi {
      border-collapse: collapse;
    }

    th {
      border-top: 1px dashed black;
      border-bottom: 1px dashed black;
    }

    .total {
      border-top: 1px double black;
      font-weight: bold;
    }

    tfoot {
      border-top: 1px dashed black;
    }

    th,
    td {
      padding: 2px;
    }

    .gray {
      background-color: lightgray
    }

    footer {
      position: fixed;
      bottom: 10px;
      left: 0px;
      right: 0px;
      height: 40px;
      font-size: 7pt;
    }
  </style>

</head>

<body>

  <table width="100%">
    <tr>
      <td style="font-size: 16pt;">PT. MEGAH ALAM SOLUSINDO</td>
      <td align="right" style="font-size: 14pt;">
        INVOICE #<?php echo $spb->inv_nomor; ?>
      </td>
    </tr>
    <tr>
      <td>
        <?php
        echo $config->alamat . '<br />' . $config->kota . '<br />Website: <a href="' . $config->website . '">' . $config->website . '</a>';
        ?>
      </td>
    </tr>
  </table>

  <table width="100%">
    <tr>
      <td width='35%'>
        BILL TO<br />
        <?php echo $spb->customer_nama . '<br />' . $spb->customer_site; ?>
      </td>
      <td></td>
      <td width='35%'>
        <table width="100%">
          <tr>
            <td>DATE</td>
            <td>:</td>
            <td><?php echo strftime("%d %b %Y", strtotime($spb->inv_tanggal)); ?></td>
          </tr>
          <tr>
            <td>INVOICE NUMBER</td>
            <td>:</td>
            <td><?php echo $spb->inv_nomor; ?></td>
          </tr>
          <tr>
            <td>DUE DATE</td>
            <td>:</td>
            <td></td>
          </tr>
          <tr>
            <td>PO NUMBER</td>
            <td>:</td>
            <td></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  <br />

  <table width="100%" class="isi">
    <thead>
      <tr>
        <th>NO</th>
        <th>DESCRIPTION</th>
        <th>QUANTITY</th>
        <th>PRICE</th>
        <th>AMOUNT</th>
      </tr>
    </thead>
    <tbody>
      <?php
      $nomor = 1;
      foreach ($items as $i) {
      ?>
        <tr>
          <td scope="row"><?php echo $nomor++; ?></td>
          <td><?php echo $i->items_desc; ?></td>
          <td align="center"><?php echo $i->items_qty . ' ' . $satuan[$i->items_satuan]; ?></td>
          <td align="right"><?php echo number_format($i->items_price); ?></td>
          <td align="right"><?php echo number_format($i->items_price * $i->items_qty); ?></td>
        </tr>
      <?php } ?>
    </tbody>
    <tfoot>
      <tr>
        <td scope="row" colspan='3'></td>
        <td>Subtotal</td>
        <td align="right"><?php echo number_format($spb->inv_total); ?></td>
      </tr>
      <tr>
        <td scope="row" colspan='3'></td>
        <td>Taxable</td>
        <td align="right"><?php echo number_format($spb->inv_total * $spb->inv_pajak / 100); ?></td>
      </tr>
      <tr>
        <td scope="row" colspan='3'></td>
        <td>Tax Rate</td>
        <td align="right"><?php echo number_format($spb->inv_pajak); ?>%</td>
      </tr>
      <tr>
        <td scope="row" colspan='3'></td>
        <td>Discount</td>
        <td align="right"><?php echo number_format($spb->inv_discount); ?></td>
      </tr>
      <tr>
        <td scope="row" colspan='3'></td>
        <td class="total">TOTAL</td>
        <td class="total" align="right"><?php echo number_format($spb->inv_total + ($spb->inv_total * $spb->inv_pajak / 100) - $spb->inv_discount); ?></td>
      </tr>
    </tfoot>
  </table>
  <?php
  $banyak = count($items);
  if ($banyak < 15) {
    for ($i = 1; $i < 5 - $banyak; $i++)
      echo '<br />';
  }
  ?>
  <br /><br />
  <table width="100%">
    <tr>
      <td width="60%">
        OTHER COMMENTS<br />
        1. Total payment due in 2 weeks<br />
        2. Please include the invoice number on your check<br />
        3. Transfer To: <br />
        BCA<br />
        8605172179<br />
        a/n M. Abidin
      </td>
      <td style="text-align: center;" valign="bottom">
        Muhammad Abidin<br />
        Direktur
      </td>
    </tr>
  </table>
  <footer>
    <hr />
    <img src="<?php echo base_url() . 'hasil/inv_' . $this->session->userid . '.png'; ?>" style="width:45px; margin:0; float: left;" />
    <div style="float: left; margin-left: 10px; position: absolute">
      Dokumen ini adalah milik CV. GLOBAL POWER.<br />
      Untuk mengecek keaslian dokumen, <br />
      silahkan scan qr code yang ada disamping.
    </div>
    <div style="float: right; margin-right: 10px;position: absolute">
      If you have any questions about this invoice, please contact<br />
      ALDINO YUDHA P ( +62 852 4721 6278 ) / MUHAMMAD ABIDIN ( +62 853 8787 8998 )<br />
      Thank You For Your Business!
    </div>
  </footer>
</body>

</html>