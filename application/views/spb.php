<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>SPB</title>

<style type="text/css">
@page {
  margin: 25px;
  size: A6 landscape;
}
    * {
        font-family: Verdana, Arial, sans-serif;
    }
    table{
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
</style>

</head>
<body >

  <table width="100%">
    <tr>
        <td style="font-size: 14pt;">DELIVERY NOTE</td>
        <td align="right" style="font-size: 12pt;">
          CV. GLOBAL POWER
        </td>
    </tr>

  </table>

  <table width="100%">
    <tr>
        <td width="30%">
          <table>
            <tr>
              <td>TO</td>
              <td>:</td>
              <td><?php echo $spb->customer_nama;?></td>
            </tr>
            <tr>
              <td>SITE</td>
              <td>:</td>
              <td><?php echo $spb->customer_site;?></td>
            </tr>
            <tr>
              <td>ATTN</td>
              <td>:</td>
              <td></td>
            </tr>
          </table>
        </td>
        <td></td>
        <td width="30%">
          <table>
            <tr>
              <td>FROM</td>
              <td>:</td>
              <td>CV. GLOBAL POWER</td>
            </tr>
            <tr>
              <td>DATE</td>
              <td>:</td>
              <td><?php echo strftime("%d %b %Y", strtotime($spb->spb_tanggal));?></td>
            </tr>
            <tr>
              <td>DN NO</td>
              <td>:</td>
              <td>DGP<?php echo $spb->spb_nomor;?></td>
            </tr>
            <tr>
              <td>REF</td>
              <td>:</td>
              <td><?php echo $spb->spb_ref;?></td>
            </tr>
          </table>
        </td>
    </tr>

  </table>

  <br/>

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
      $nomor=1;
        foreach($items as $i){
      ?>
      <tr>
        <th scope="row"><?php echo $nomor++;?></th>
        <td><?php echo $i->items_desc;?></td>
        <td align="center"><?php echo $i->items_qty.' '.$satuan[$i->items_satuan];?></td>
        <td align="right"></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
  <?php
  $banyak = count($items);
  if($banyak<5){
    for($i=1;$i<5-$banyak;$i++)
      echo '<br />';
  }
  ?>
  <br /><br />
  <table width="100%">
    <tr>
        <td width="33%" style="text-align: center;">
          PREPARED BY
          <br /><br /><br />
          <?php
            if($spb->spb_pengirim=='')
              echo '(...............)';
            else
              echo $spb->spb_pengirim;
          ?>

        </td>
        <td style="text-align: center;">
          AUTHORIZED BY
          <br /><br /><br />
          (...............)
        </td>
        <td width="33%" style="text-align: center;">
          RECEIVED BY
          <br /><br /><br />
          (...............)
        </td>
    </tr>
  </table>
  <!-- <footer>
    <hr />
    <img src="<?php echo FCPATH.'hasil/barcode_'.$this->session->userid.'.png';?>" style="width:45px; margin:0; float: left;"/>
    <p style="margin-top: 0px; margin-left: 10px;">
      Dokumen ini adalah milik CV. GLOBAL POWER.<br />
      Untuk mengecek keaslian dokumen, <br />silahkan scan qr code yang ada disamping.<br />
    </p>
  </footer> -->
</body>
</html>
