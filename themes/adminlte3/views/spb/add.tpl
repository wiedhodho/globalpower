{extends file="master/index.tpl"}

{block name='css'}
<link rel="stylesheet" href="{theme_url()}plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="{theme_url()}plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
{/block}

{block name='js'}
<script src="{theme_url()}plugins/select2/js/select2.full.min.js"></script>
<script src="{theme_url()}plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<script>
$(function () {
  'use strict';
  $('.select2').select2();
  // $("input[data-bootstrap-switch]").each(function(){
    $("input[data-bootstrap-switch]").bootstrapSwitch('state');
  // });
  $('#reservationdate').datetimepicker({
        format: 'DD/MM/YYYY'
  });
  let id=2;
  $('#tambah').click(function(){
    let cur = $('#tambahan').html();
    $('#tambahan').append(
    '<div class="row" id="baris_'+id+'">' +
      '<div class="form-group col-lg-1">' +
        '<label></label>' +
        '<input type="text" class="form-control" placeholder="Enter ..." value="'+id+'" readonly>' +
      '</div>' +
      '<div class="form-group col-lg-4">' +
        '<label></label>' +
        '<input name="desc['+id+']" type="text" class="form-control" placeholder="Enter Desc..." required>' +
      '</div>' +
      '<div class="form-group col-lg-1">' +
        '<label></label>' +
        '<input name="qty['+id+']" type="number" class="form-control qty" placeholder="Enter qty" value="1" id="qty_'+id+'" onChange="qty(this, '+id+')" required>' +
      '</div>' +
      '<div class="form-group col-lg-2">' +
        '<label></label>' +
        '<select name="satuan['+id+']" class="form-control" required>' +
          '{foreach from=$satuan item=s key=k}' +
          '<option value="{$k}">{$s}</option>' +
          '{/foreach}' +
        '</select>' +
      '</div>' +
      '<div class="form-group col-lg-2">' +
        '<label></label>' +
        '<input name="price['+id+']" type="number" class="form-control price" placeholder="Enter price" id="price_'+id+'" onChange="price(this,'+id+')" value="1000" required>' +
      '</div>' +
      '<div class="form-group col-lg-1">' +
        '<label></label>' +
        '<input name="total['+id+']" type="text" class="form-control text-right total" id="total_'+id+'" value="1000" readonly>' +
      '</div>' +
      '<div class="form-group col-lg-1">' +
        '<label></label>' +
        '<div style="">' +
          '<button type="button" class="btn btn-danger form-control" onClick="hapus('+id+')"><i class="fa fa-trash"></i> Hapus</button>' +
        '</div>' +
      '</div>' +
    '</div>'
    );
    id++;
    total();
  });
  $('.hitung').change(function(){
    total();
  })
})
function hapus(id){
  $('#baris_'+id).remove();
  total();
}

function price(th, id){
  let jumlah = $('#qty_'+id).val() * th.value;
  $('#total_'+id).val(jumlah);
  total();
}
function qty(th, id){
  let jumlah = $('#price_'+id).val() * th.value;
  $('#total_'+id).val(jumlah);
  total();
}

function total(){
  var sum = 0, pajak, disc;
  $('.total').each(function(){
      sum += parseInt($(this).val());
      // console.log($(this).val());
  });
  $('#total_sebelum').val(sum.toLocaleString());
  pajak = sum * $('#pajak').val() / 100;
  sum = sum + pajak;
  disc = $('#discount').val();
  sum = sum - disc;
  $('#total').val(sum.toLocaleString());
}
</script>
{/block}

{block name='content'}
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <div class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1 class="m-0 text-dark">{$halaman|end}</h1>
        </div><!-- /.col -->
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="{base_url()}">Home</a></li>
            {foreach from=$halaman item=a key=k}
            {if $a==$halaman|end}
            <li class="breadcrumb-item active">{$a}</li>
            {else}
            <li class="breadcrumb-item"><a href="{base_url()}{$k}">{$a}</a></li>
            {/if}
            {/foreach}
          </ol>
          <br />
        </div><!-- /.col -->
      </div><!-- /.row -->
    </div><!-- /.container-fluid -->
  </div>
  <!-- /.content-header -->

  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-lg-8">
          <form class="form-horizontal" method="post" action="{base_url('spb/save')}">
            <div class="card card-info">
              <div class="card-header">
                <h5 class="card-title">Form SPB</h5>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                  <div class="card-body">
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-3 col-form-label">Jenis</label>
                      <div class="col-sm-9">
                        {$jenis[$quo->quotation_jenis]}
                        <input type="hidden" name="id" value="{$quo->quotation_id}" />
                        <input type="hidden" name="customer" value="{$quo->customer_id}" />
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-3 col-form-label">Customer</label>
                      <div class="col-sm-9">
                        {if $quo->customer_site==''}
                          {$nama = $quo->customer_nama}
                        {else}
                          {$nama = $quo->customer_nama|cat:' - Site '|cat:$quo->customer_site}
                        {/if}
                        {$nama}
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputPassword3" class="col-sm-3 col-form-label">Tanggal</label>
                      <div class="col-lg-3">
                        <div class="input-group date" id="reservationdate" data-target-input="nearest">
                            <input type="text" name="tanggal" class="form-control datetimepicker-input" data-target="#reservationdate" data-toggle="datetimepicker" value="{$smarty.now|date_format:'%d/%m/%Y'}" required/>
                            <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                            </div>
                        </div>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-3 col-form-label">Pengirim</label>
                      <div class="col-lg-4">
                        <input type="text" class="form-control hitung" placeholder="Nama Pengirim" name="pengirim" >
                      </div>
                    </div>
                  </div>
              </div>
              <!-- ./card-body -->
            </div>
            <div class="card card-info">
              <div class="card-header">
                <h5 class="card-title">Items</h5>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="card-body">
                  <table class="table">
                    <thead>
                      <tr>
                        <th>No</th>
                        <th>Desc</th>
                        <th>Qty</th>
                      </tr>
                    </thead>
                    <tbody>
                      {foreach from=$items item=i}
                      <tr>
                        <td>{counter}</td>
                        <td>{$i->items_desc}</td>
                        <td>{$i->items_qty} {$satuan[$i->items_satuan]}</td>
                      </tr>
                      {/foreach}
                    </tbody>
                  </table>
                </div>
              </div>
              <div class="card-footer">
                <button type="submit" class="btn btn-info"><i class="fa fa-save"></i> Simpan</button>
              </div>
              <!-- ./card-body -->
            </div>
          </form>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </div><!--/. container-fluid -->
  </section>
  <!-- /.content -->
</div>
{/block}
