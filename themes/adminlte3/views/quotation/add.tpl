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
        <div class="col-lg-12">
          <form class="form-horizontal" method="post" action="{base_url('quotation/save')}">
            <div class="card card-info">
              <div class="card-header">
                <h5 class="card-title">Form Quotation</h5>

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
                      <label for="inputEmail3" class="col-sm-3 col-form-label">Credit / Cash</label>
                      <div class="col-sm-9">
                        <input type="checkbox" name="cash" data-on-text="Cash" data-off-text="Credit" data-bootstrap-switch>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-3 col-form-label">Jenis</label>
                      <div class="col-sm-9">
                        <select name="jenis" class="form-control" required>
                          <option value="">Pilih Jenis</option>
                          {foreach from=$jenis item=j key=k}
                          <option value="{$k}">{$j}</option>
                          {/foreach}
                        </select>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputPassword3" class="col-sm-3 col-form-label">Tanggal</label>
                      <div class="col-lg-2">
                        <div class="input-group date" id="reservationdate" data-target-input="nearest">
                            <input type="text" name="tanggal" class="form-control datetimepicker-input" data-target="#reservationdate" data-toggle="datetimepicker" value="{$smarty.now|date_format:'%d/%m/%Y'}" required/>
                            <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                            </div>
                        </div>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-3 col-form-label">Customer</label>
                      <div class="col-sm-9">
                        <select class="form-control select2" style="width: 100%;" name="customer" required>
                          <option value="">Pilih Customer</option>
                          {foreach from=$cust item=c}
                          {if $c->customer_site==''}
                            {$nama = $c->customer_nama}
                          {else}
                            {$nama = $c->customer_nama|cat:' - Site '|cat:$c->customer_site}
                          {/if}
                          <option value="{$c->customer_id}">{$nama}</option>
                          {/foreach}
                        </select>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-3 col-form-label">PPN / Discount</label>
                      <div class="input-group col-lg-1">
                        <input type="number" class="form-control hitung" placeholder="Pajak" name="pajak" value="10" id="pajak" required>
                        <div class="input-group-append">
                          <span class="input-group-text">%</span>
                        </div>
                      </div>
                      <div class="col-lg-2">
                        <input type="number" class="form-control text-right hitung" placeholder="Discount" name="discount" id="discount" value="0" required>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-3 col-form-label">Total sblm Pajak</label>
                      <div class="col-lg-3">
                        <input type="text" class="form-control text-right" placeholder="0" name="total_sebelum" id="total_sebelum" required readonly>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputEmail3" class="col-sm-3 col-form-label">Total stlh Pajak - Disc</label>
                      <div class="col-lg-3">
                        <input type="text" class="form-control text-right" placeholder="0" name="total_sesudah" id="total" required readonly>
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
                  <div class="row">
                    <div class="form-group col-lg-1">
                      <label>No.</label>
                      <input type="text" class="form-control" placeholder="Enter ..." value="1" readonly>
                    </div>
                    <div class="form-group col-lg-4">
                      <label>Desc</label>
                      <input name="desc[1]" type="text" class="form-control" placeholder="Enter Desc..." required>
                    </div>
                    <div class="form-group col-lg-1">
                      <label>Qty</label>
                      <input name="qty[1]" type="number" class="form-control qty" placeholder="Enter qty" id="qty_1" onChange="qty(this,1)" required>
                    </div>
                    <div class="form-group col-lg-2">
                      <label>Satuan</label>
                      <select name="satuan[1]" class="form-control" required>
                        {foreach from=$satuan item=s key=k}
                        <option value="{$k}">{$s}</option>
                        {/foreach}
                      </select>
                    </div>
                    <div class="form-group col-lg-2">
                      <label>Unit Price</label>
                      <input name="price[1]" type="number" class="form-control price" placeholder="Enter price" onChange="price(this,1)" id="price_1" required>
                    </div>
                    <div class="form-group col-lg-1">
                      <label>Total</label>
                      <input name="total[1]" type="text" class="form-control text-right total" value="" id="total_1" readonly>
                    </div>
                    <div class="form-group col-lg-1">
                      <label></label>
                      <div style="margin-top:8px;">
                        <button type="button" class="btn btn-success form-control" id="tambah"><i class="fa fa-plus"></i> Tambah</button>
                      </div>
                    </div>
                  </div>
                  <div id="tambahan">
                  </div>
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
