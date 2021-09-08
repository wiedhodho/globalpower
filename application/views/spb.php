<!doctype html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>SPB</title>

  <style type="text/css">
    @page {
      margin: 25px;
      font-size: 7pt;
      size: A6 landscape;
    }

    * {
      font-family: Verdana, Arial, sans-serif;
    }

    table {
      font-size: 6pt;
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
  </style>

</head>

<body>
  <div class="text-right">
    <img src="<?= base_url() ?>/img/logo.png" border="0" width="200px" />
  </div>
  <h2 style="padding: 2px;border-top: 1px solid #000; border-bottom: 1px solid #000">DELIVERY NOTE</h2>
  <table>
    <tr>
      <td>No.</td>
      <td>:</td>
      <td><?php echo $spb->spb_nomor . '/SJ-MAS/' . strftime("%Y", strtotime($spb->spb_tanggal)); ?></td>
    </tr>
    <tr>
      <td>Customer Name</td>
      <td>:</td>
      <td><?php echo $spb->customer_nama; ?></td>
    </tr>
    <tr>
      <td>Date</td>
      <td>:</td>
      <td><?php echo strftime("%d %b %Y", strtotime($spb->spb_tanggal)); ?></td>
    </tr>
    <tr>
      <td>Kode Kendaraan</td>
      <td>:</td>
      <td></td>
    </tr>
  </table>
  <br /><br />

  <table width="100%">
    <thead style="background-color: lightgray;">
      <tr>
        <th>NO</th>
        <th>DESCRIPTION</th>
        <th>QUANTITY</th>
        <th>REMARKS</th>
      </tr>
    </thead>
    <tbody>
      <?php
      $nomor = 1;
      foreach ($items as $i) {
      ?>
        <tr>
          <th scope="row"><?php echo $nomor++; ?></th>
          <td><?php echo $i->items_desc; ?></td>
          <td align="center"><?php echo $i->items_qty . ' ' . $satuan[$i->items_satuan]; ?></td>
          <td align="right"></td>
        </tr>
      <?php } ?>
    </tbody>
  </table>
  <?php
  $banyak = count($items);
  if ($banyak < 5) {
    for ($i = 1; $i < 5 - $banyak; $i++)
      echo '<br />';
  }
  ?>
  <br /><br />
  <table width="100%">
    <tr>
      <td width="33%" style="text-align: center;">
        Penerima,
        <br /><br /><br />
        (...............)
      </td>
      <td style="text-align: center;">
        Diangkut,
        <br /><br /><br />
        (...............)
      </td>
      <td width="33%" style="text-align: center;">
        Dibuat,
        <br /><br /><br />
        (...............)
      </td>
    </tr>
  </table>
</body>

</html>