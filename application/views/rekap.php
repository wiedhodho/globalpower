<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>TT Invoice</title>

  <style type="text/css">
    @page {
      margin: 30px;
      font-size: 8pt;
      size: A4;
    }

    * {
      font-family: Verdana, Arial, sans-serif;
    }

    table {
      font-size: 7pt;
    }

    table.isi {
      border-collapse: collapse;
      border: 1px solid #777777;
    }

    .isi th,
    .isi td {
      border: 1px solid #777777;
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
      height: 35px;
      font-size: 6pt;
    }

    .text-right {
      text-align: right;
    }

    .text-center {
      text-align: center;
    }
  </style>

</head>

<body>
  <div class="text-right">
    <img src="<?= base_url() ?>/img/logo.png" border="0" width="200px" />
  </div>
  <div class="text-center">
    <h2 style="padding: 2px; border-bottom: 1px solid #000">TANDA TERIMA INVOICE (TT)</h2>
  </div>
  <table>
    <tr>
      <td>TT No.</td>
      <td>:</td>
      <td><?php echo $rekap->rekap_id; ?></td>
    </tr>
    <tr>
      <td>Customer Name</td>
      <td>:</td>
      <td><?php echo $inv[0]->customer_nama; ?></td>
    </tr>
    <tr>
      <td>Date</td>
      <td>:</td>
      <td><?php echo strftime("%d %b %Y", strtotime($rekap->rekap_tanggal)); ?></td>
    </tr>
  </table>
  <br /><br />
  Terlampir kami kirimkan Dokumen Invoice sebagai berikut:
  <table width="100%" class="isi">
    <thead style="background-color: lightgray;">
      <tr>
        <th>NO</th>
        <th>INVOICE NO.</th>
        <th>TOTAL</th>
        <th>PO/REMARKS</th>
      </tr>
    </thead>
    <tbody>
      <?php
      $nomor = 1;
      foreach ($inv as $i) {
      ?>
        <tr>
          <td scope="row"><?php echo $nomor++; ?></td>
          <td><?php echo $i->inv_nomor; ?></td>
          <td align="right"><?php echo number_format($i->inv_total); ?></td>
          <td align="center"><?= $i->quotation_po ?></td>
        </tr>
      <?php } ?>
    </tbody>
  </table>
  <br /><br />
  <b><u>Note:</u></b><br />
  Setelah diterima mohon ditanda tangani dan stempel,
  lembar 1 Kembali Ke Kantor, Lembar 2 untuk customer.<br /><br /><br />
  <?php
  $banyak = count($inv);
  if ($banyak < 20) {
    for ($i = 1; $i < 20 - $banyak; $i++)
      echo '<br />';
  }
  ?>
  <br /><br />
  <table width="100%">
    <tr>
      <td width="50%" style="text-align: center;">
        Pengirim,<br />
        PT. Megah Alam Solusindo
        <br /><br /><br /><br />
        (Muhammad Abidin)
      </td>
      <td style="text-align: center;">
        Penerima,
        <br /><br /><br /><br /><br />
        (...............)
      </td>
    </tr>
  </table>
</body>

</html>